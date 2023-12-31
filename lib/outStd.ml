(****************************************************************************)
(*                           the diy toolsuite                              *)
(*                                                                          *)
(* Jade Alglave, University College London, UK.                             *)
(* Luc Maranget, INRIA Paris-Rocquencourt, France.                          *)
(*                                                                          *)
(* Copyright 2016-present Institut National de Recherche en Informatique et *)
(* en Automatique and the authors. All rights reserved.                     *)
(*                                                                          *)
(* This software is governed by the CeCILL-B license under French law and   *)
(* abiding by the rules of distribution of free software. You can use,      *)
(* modify and/ or redistribute the software under the terms of the CeCILL-B *)
(* license as circulated by CEA, CNRS and INRIA at the following URL        *)
(* "http://www.cecill.info". We also give a copy in LICENSE.txt.            *)
(****************************************************************************)


(** Output litmus files, contatenate on stdout *)

open Printf


type t = No | Out

let open_all () = No
let open_file _ = Out
let close _ = ()
let remove _ = ()

let put_char out c = match out with
| No -> ()
| Out -> output_char stdout c

let fprintf t fmt =  match t with
| No -> ifprintf stdout fmt
| Out -> fprintf stdout fmt

let tar () = ()

let chan = function
  | No -> assert false
  | Out -> stdout
