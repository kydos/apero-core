module type S = sig 
  type t 
  val zero : t
  val one : t
  val add : t -> t -> t 
  val next_id : unit -> t
  val compare : t -> t -> int  
  val equal : t -> t -> bool
  val show : t -> string
  val to_string : t -> string
  val of_string : string -> t 
  val of_string_opt : string -> t option 
end 

module type IdSignature = sig
  type t
  val zero : t 
  val one : t 
  val add : t -> t -> t
  val equal : t -> t -> bool
  val compare : t -> t -> int
  val to_string : t -> string
  val of_string : string -> t 
  val of_string_opt : string -> t option 
end 

module Make(T : IdSignature) = struct 
  include T

  type state = {mutable count : T.t }

  let state = { count = T.zero }  
  
  let next_id () =
    let r = state.count in  
    (** roll-over to negatives and eventually back to zero*)
    state.count <- T.add state.count T.one ; r    
  
  let show = T.to_string
end