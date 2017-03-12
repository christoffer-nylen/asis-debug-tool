procedure Hello is

   A : Integer := 1;
   B : Integer := 42;

   type Primary_Color is (Red, Green, Blue);
   C : Primary_Color := Green;
   D : Primary_Color := Blue;

   E : Boolean := True;
   F : Boolean := False;

begin

   if A < B then
      null;
   end if;

   if C < D then
      null;
   end if;

   if E = F then
      null;
   end if;

end Hello;
