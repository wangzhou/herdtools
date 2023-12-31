(****************************************************************************)
(*                           the diy toolsuite                              *)
(*                                                                          *)
(* Jade Alglave, University College London, UK.                             *)
(* Luc Maranget, INRIA Paris-Rocquencourt, France.                          *)
(*                                                                          *)
(* Copyright 2014-present Institut National de Recherche en Informatique et *)
(* en Automatique and the authors. All rights reserved.                     *)
(*                                                                          *)
(* This software is governed by the CeCILL-B license under French law and   *)
(* abiding by the rules of distribution of free software. You can use,      *)
(* modify and/ or redistribute the software under the terms of the CeCILL-B *)
(* license as circulated by CEA, CNRS and INRIA at the following URL        *)
(* "http://www.cecill.info". We also give a copy in LICENSE.txt.            *)
(****************************************************************************)

(* Base type for produced tests *)

open MachSize

type sgn = Signed | Unsigned

type t =   Int | Std of sgn * MachSize.sz | Pteval

let tags =
  ["int";
   "int8_t"; "uint8_t";
   "int16_t"; "uint16_t";
   "int32_t"; "uint32_t";
   "int64_t"; "uint64_t";
   "int128_t"; "uint128_t";
   "__int128"; "__uint128";
 ]

let parse s = match s with
| "int" -> Some Int
| "int8_t" -> Some (Std (Signed,Byte))
| "uint8_t" -> Some (Std (Unsigned,Byte))
| "int16_t" -> Some (Std (Signed,Short))
| "uint16_t" -> Some (Std (Unsigned,Short))
| "int32_t" -> Some (Std (Signed,Word))
| "uint32_t" -> Some (Std (Unsigned,Word))
| "int64_t" -> Some (Std (Signed,Quad))
| "uint64_t" -> Some (Std (Unsigned,Quad))
| "int128_t" -> Some (Std (Signed,S128))
| "uint128_t" -> Some (Std (Unsigned,S128))
| "__int128" -> Some (Std (Signed,S128))
| "__uint128" -> Some (Std (Unsigned,S128))
| _ -> None

let pp = function
| Int ->  "int"
| Std (Signed,Byte) ->  "int8_t"
| Std (Unsigned,Byte) ->  "uint8_t"
| Std (Signed,Short) ->  "int16_t"
| Std (Unsigned,Short) ->  "uint16_t"
| Std (Signed,Word) ->  "int32_t"
| Std (Unsigned,Word) ->  "uint32_t"
| Std (Signed,Quad) ->  "int64_t"
| Std (Unsigned,Quad) ->  "uint64_t"
| Std (Signed,S128) ->  "__int128"
| Std (Unsigned,S128) ->  "__uint128"
| Pteval -> "pteval_t"


let sign_equal s1 s2 = match s1,s2 with
| (Unsigned,Unsigned)
| (Signed,Signed)
  -> true
| (Unsigned,Signed)
| (Signed,Unsigned)
  -> false

let equal t1 t2 = match t1,t2 with
| (Int,Int)
| (Pteval,Pteval)
  -> true
| (Std (s1,sz1),Std (s2,sz2))
  -> sign_equal s1 s2 && MachSize.equal sz1 sz2
| ((Int|Pteval),Std _)
| (Std _,(Int|Pteval))
| (Int,Pteval)
| (Pteval,Int)
  -> false

let default = Int
let is_default = function
  | Int -> true
  | _ -> false

let pteval_t = Pteval
let is_pteval_t = function
  | Pteval -> true
  | _ -> false

let get_size = function
  | Int -> Word
  | Std (_,sz) -> sz
  | Pteval -> Quad
