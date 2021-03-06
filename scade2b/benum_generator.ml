(* =========================================================================== *)
(* == CERCLES2 -- ANR-10-SEGI-017                                           == *)
(* =========================================================================== *)
(* == benum_generator.ml                                                    == *)
(* ==                                                                       == *)
(* ==                                                                       == *)
(* =========================================================================== *)
(* == Florian Thibord - florian.thibord[at]gmail.com                        == *)
(* =========================================================================== *)

open Format
open Ast_kcg
open Ast_scade_norm
open Ast_prog
open Printer

let print_enum ppt enum =
  fprintf ppt "%s = {%a}" 
    enum.p_enum_id
    print_idlist_comma enum.p_enum_list

let print_enum_list =
  print_list ~sep:"; " ~break:true ~forcebreak:true print_enum

let print_sets_clause ppt enum_list =
  if enum_list <> [] then
    fprintf ppt "SETS %a@\n" print_enum_list enum_list

let print_machine ppt enum_list =
  fprintf ppt
    "MACHINE M_Enum@\n%aEND"
    print_sets_clause enum_list

let print_m_enum enum_list file env_prog =
    with_env env_prog (fun () ->
        fprintf (formatter_of_out_channel file) "%a@." print_machine enum_list
    )
