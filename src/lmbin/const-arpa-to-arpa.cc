// lmbin/arpa-to-const-arpa.cc

// Copyright 2014  Guoguo Chen

// See ../../COPYING for clarification regarding multiple authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
// THIS CODE IS PROVIDED *AS IS* BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION ANY IMPLIED
// WARRANTIES OR CONDITIONS OF TITLE, FITNESS FOR A PARTICULAR PURPOSE,
// MERCHANTABILITY OR NON-INFRINGEMENT.
// See the Apache 2 License for the specific language governing permissions and
// limitations under the License.

#include <string>


#include "base/kaldi-math.h"
#include "lm/arpa-file-parser.h"
#include "lm/const-arpa-lm.h"
#include "util/stl-utils.h"
#include "util/text-utils.h"
//#include "lm/const-arpa-lm.h"
#include "util/parse-options.h"
#include "lm/const-arpa-lm.cc"

bool BuildNewConstArpaLm(const kaldi::ArpaParseOptions& options,
                      const std::string& arpa_rxfilename,
                      const std::string& const_arpa_wxfilename) {
  //kaldi::ConstArpaLmBuilder lm_builder(options);

  kaldi::ConstArpaLm const_arpa;
  kaldi::ReadKaldiObject(arpa_rxfilename, &const_arpa);
  KALDI_LOG << "Reading " << arpa_rxfilename;
  //kaldi::ReadKaldiObject(arpa_rxfilename, &lm_builder);
  //kaldi::ReadKaldiObject(lm_builder, const_arpa_wxfilename, true);
  //kaldi::WriteKaldiObject(lm_builder, const_arpa_wxfilename, true);
  //std::ifstream is (arpa_rxfilename, std::ifstream::binary);
  std::ofstream outfile (const_arpa_wxfilename, std::ofstream::binary);
  const_arpa.WriteArpa(outfile);
  //std::istream is;
  //lm_builder.Read(is,true);
  //lm_builder.Write(outfile, false);
  return true;
}

int main(int argc, char *argv[]) {
  using namespace kaldi;
  typedef kaldi::int32 int32;
  try {
    const char *usage  =
        "Usage: const-arpa-to-arpa [opts] <input-const-arpa> <arpa>\n"
        " e.g.: const-arpa-to-arpa --bos-symbol=1 --eos-symbol=2 \\\n"
        "                          arpa.txt const_arpa";

    kaldi::ParseOptions po(usage);

    ArpaParseOptions options;
    options.Register(&po);

    // Ideally, these registrations would be in ArpaParseOptions, but some
    // programs want integers and other want symbols, so we register them
    // outside instead.
/*
    po.Register("unk-symbol", &options.unk_symbol,
                "Integer corresponds to unknown-word in language model. -1 if "
                "no such word is provided.");
    po.Register("bos-symbol", &options.bos_symbol,
                "Integer corresponds to <s>. You must set this to your actual "
                "BOS integer.");
    po.Register("eos-symbol", &options.eos_symbol,
                "Integer corresponds to </s>. You must set this to your actual "
                "EOS integer.");
*/
    po.Read(argc, argv);

    if (po.NumArgs() != 2) {
      po.PrintUsage();
      exit(1);
    }
/*
    if (options.bos_symbol == -1 || options.eos_symbol == -1) {
      KALDI_ERR << "Please set --bos-symbol and --eos-symbol.";
      exit(1);
    }
*/
    std::string arpa_rxfilename = po.GetArg(1),
        const_arpa_wxfilename = po.GetOptArg(2);

    bool ans = BuildNewConstArpaLm(options, arpa_rxfilename,
                                const_arpa_wxfilename);
    if (ans)
      return 0;
    else
      return 1;
  } catch(const std::exception &e) {
    std::cerr << e.what() << '\n';
    return -1;
  }
}
