with
  Ada.Text_Io;

pragma Optimize(Off);

procedure Hello is

   type CustomerProfile is record
      Preferred : boolean;
   end record;
   pragma Pack( CustomerProfile );

begin
   null;
end Hello;
