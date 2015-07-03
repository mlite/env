/*
 * ExternalPass.cpp
 *
 *  Created on: Jul 2, 2015
 *      Author: nwang
 */
#include "clang/Basic/Diagnostic.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/ToolOutputFile.h"
#include "llvm/PassManager.h"
#include "llvm/Support/PrettyStackTrace.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Bitcode/BitcodeWriterPass.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/SourceMgr.h"
#include <time.h>
#include <sstream>
#include <string>
using namespace clang;
using namespace llvm;

extern "C" {
	const char * externalModulePassName(void) __attribute__((weak));
	int externalModulePass(const char *) __attribute__((weak));
}

Module * runExternalModulePass (DiagnosticsEngine &Diags, Module * TheModule)
{

	if (externalModulePassName != NULL && externalModulePass != NULL)
	{
		const char * passName = externalModulePassName();
		PrettyStackTraceString CrashInfo(passName);
		const std::string originalModuleId = TheModule->getModuleIdentifier();
		PassManager * mp = new PassManager();
		mp->add(new DataLayoutPass(TheModule));
		std::string ErrorInfo;

		std::string outputFileName = std::string("/tmp/");
		if (originalModuleId.compare("-") == 0) {
			srand(time(NULL));
			std::ostringstream convert;
			convert << rand();
			outputFileName.append(convert.str());
		} else {
			std::string tempModuleId = std::string(originalModuleId);
			std::replace (tempModuleId.begin(), tempModuleId.end(), '/', '_');
			outputFileName.append(tempModuleId);
		}
		outputFileName.append(".");
		outputFileName.append(passName);
		outputFileName.append(".bc");
		tool_output_file * Out = new tool_output_file(outputFileName.c_str(), ErrorInfo, sys::fs::F_None);
		raw_ostream * myOS = &(Out->os());
		mp->add(createBitcodeWriterPass(*myOS));
		mp->run(*TheModule);
		Out->os().close();
		Out->keep();
  	    //llvm::errs() << "store Module" << TheModule->getModuleIdentifier() << "  in " << outputFileName << "\n";

		int ret = externalModulePass(outputFileName.c_str());
		if (ret) {
			unsigned DiagID = Diags.getCustomDiagID(DiagnosticsEngine::Error, "externalPass '%0' failed on '%1'");
			Diags.Report(DiagID) << passName << originalModuleId;
			exit(ret);
		}

		SMDiagnostic Err;
		TheModule = llvm::ParseIRFile(outputFileName, Err, TheModule->getContext());
		// restore the original module Id.
		TheModule->setModuleIdentifier(originalModuleId);
		//llvm::errs() << "load Module" << TheModule->getModuleIdentifier() << "  from " << outputFileName << "\n";

		// Set up the per-function pass manager.
		FunctionPassManager *FPM = new FunctionPassManager(TheModule);
		FPM->add(new DataLayoutPass(TheModule));
		FPM->add(createVerifierPass());

		// Set up the per-module pass manager.
		PassManager *MPM = new PassManager();
		MPM->add(new DataLayoutPass(TheModule));
		MPM->add(createDebugInfoVerifierPass());
	}
	return TheModule;
}
