(*
Theory: isabelle_problems.thy
Author: Jeremy avigad

Sample problems, for comparison with the Polya inequality prover.
*)

theory isabelle_problems

imports Complex_Main

begin

(* sledgehammer and auto fail on this *)
lemma "(0::real) < u ==> u < v ==> v < 1 ==> 2 <= x \<Longrightarrow> x <= y \<Longrightarrow> 2 * u * v^2 < v * y^2"
  apply (simp add: field_simps eval_nat_numeral)
by (rule mult_strict_mono, auto)

(* even this is nontrivial for sledgehammer *)
lemma "(0 :: real) < 1 + y^2"
by (metis add_commute less_add_one linorder_neqE_linordered_idom pos_add_strict 
  power2_less_0 zero_less_one)

(* but sledgehammer eventually finds an easy solution using z3 *)
lemma "(0 :: real) < 1 + y^2"
by (smt power2_less_0)

(* sledgehammer and auto fail on this *)
lemma "(1::real) < x ==> (1 + y^2) * x > (1 + y^2)"
  apply (subst mult.right_neutral [of "1 + y^2", symmetric])
  apply (rule mult_le_less_imp_less, auto)
by (smt power2_less_0) 

(* sledgehammer and auto fail on this *)
lemma "(0::real) < x ==> x < 1 ==> 1 / (1 - x) > 1 / (1 - x^2)"
  apply (auto simp add: field_simps eval_nat_numeral)
  apply (rule mult_imp_div_pos_less)
  apply (auto simp add: field_simps)
  apply (subst mult.right_neutral [of 1, symmetric])
by (rule mult_strict_mono, auto)

(* sledgehammer gets this easily *)
lemma "(ALL x y. x <= y --> f x <= f y) ==> (u::real) < v ==> (x::real) <= y ==> 
    u + f x < v + f y"
by (metis add_less_le_mono)

(* sledgehammer finds a solution with Z3 *)
lemma "(ALL x y. x <= y --> f x <= f y) ==> (u::real) < v ==> 1 < v ==> (x::real) <= y ==> 
    f x + u < v^2 + f y"
by (smt power_less_imp_less_exp power_one_right)

(* again here *)
lemma "(ALL x y. x <= y --> f x <= f y) ==> (u::real) < v ==> 1 < v ==> (x::real) <= y ==> 
    f x + u < (1 + v)^10 + f y"
by (smt power_one_right power_strict_increasing_iff)

(* sledgehammer gets this *)
lemma "(ALL x. f x <= 1) ==> (0::real) < w ==> u < v ==> u + w * f x < v + w"
by (metis add_less_le_mono monoid_mult_class.mult.right_neutral real_mult_le_cancel_iff2)

(* but not this *)
lemma "(ALL x. f x <= 2) ==> (0::real) < w ==> u < v ==> u + w * (f x - 1) < v + w"
  apply (erule add_less_le_mono)
  apply (subst (2) mult.right_neutral [of w, symmetric])
  by (rule mult_left_mono, auto)

(* sledgehammer finds a solution using resolution *)
lemma "(0::real) < x ==> x < y ==> u < v ==>
    2 * u + exp (1 + x + x^4) <= 2 * v + exp (1 + y + y^4)"
by (metis add_less_cancel_left add_mono_thms_linordered_field(5) exp_less_cancel_iff less_eq_real_def mult_2 power_strict_mono zero_less_numeral)

(* sledgehammer finds a solution using Z3 *)
lemma "(0::real) < x ==> x < y ==> u < v ==>
    2 * u + exp (1 + x + x^4) <= 2 * v + exp (1 + y + y^4)"
by (smt exp_le_cancel_iff power_less_imp_less_base)

(* sledgehammer fails here *)
lemma "(0::real) <= n ==> n < (K / 2) * x ==> 0 < C ==> 0 < eps ==> eps < 1 ==> 
    (1 + eps / (3 * (C + 3))) * n < K * x"
  apply (subgoal_tac "K * x = 2 * ((K / 2) * x)")
  apply (erule ssubst)
by (rule mult_le_less_imp_less, auto simp add: field_simps)

  

end
  