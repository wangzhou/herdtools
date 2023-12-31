(****************************************************************************)
(*                           the diy toolsuite                              *)
(*                                                                          *)
(* Jade Alglave, University College London, UK.                             *)
(* Luc Maranget, INRIA Paris-Rocquencourt, France.                          *)
(*                                                                          *)
(* Copyright 2010-present Institut National de Recherche en Informatique et *)
(* en Automatique, ARM Ltd and the authors. All rights reserved.            *)
(*                                                                          *)
(* This software is governed by the CeCILL-B license under French law and   *)
(* abiding by the rules of distribution of free software. You can use,      *)
(* modify and/ or redistribute the software under the terms of the CeCILL-B *)
(* license as circulated by CEA, CNRS and INRIA at the following URL        *)
(* "http://www.cecill.info". We also give a copy in LICENSE.txt.            *)
(****************************************************************************)

(** Tests for the OcamlString module. *)

let tests = [
  "OcamlString.record", (fun () ->
    let tests = [
      [], "{}" ;
      ["a", Base.String.to_ocaml_string "b"], "{ a = \"b\" }" ;
      [
        "a", Base.String.to_ocaml_string "b" ;
        "c", Base.String.to_ocaml_string "d" ;
      ], "{ a = \"b\" ; c = \"d\" }" ;
    ] in

    List.iter
      (fun (fields, expected) ->
        let actual = OcamlString.record fields in
        if String.compare actual expected <> 0 then
          Test.fail (Printf.sprintf "expected %s, got %s" expected actual)
      )
      tests
  );
]

let () = Test.run tests
