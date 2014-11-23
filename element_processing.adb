-- ADA
with
  Ada.Text_Io,
  Ada.Wide_Text_Io,
  Ada.Characters.Handling,
  Ada.Command_Line,
  Ada.Strings.Bounded,
  Ada.Strings,
  Ada.Strings.Wide_Fixed;
use
  Ada.Wide_Text_Io;

-- ASIS
with
  Asis,
  Asis.Clauses,
  Asis.Errors,
  Asis.Exceptions,
  Asis.Implementation,
  Asis.Ada_Environments,
  Asis.Compilation_Units,
  Asis.Elements,
  Asis.Iterator,
  Asis.Declarations,
  Asis.Definitions,
  Asis.Expressions,
  Asis.Extensions,
  Asis.Statements,
  Asis.Text;

--Data structures
--with
--Stack_Array;

--Adalog
with
  Thick_Queries;

with
  Context_Arguments;

-- Adalog
with
  Utilities;

procedure Element_Processing is
   type Access_Function is access function (Element : Asis.Element) return Asis.Element;

   package My_Strings is new Ada.Strings.Bounded.Generic_Bounded_Length(100);
   use My_Strings;

   type Asis_Query is
      record
         Call : Access_Function;
         Name : BOUNDED_STRING;
      end record;

   procedure Display(Name : BOUNDED_STRING) is
      use Ada.Characters.Handling;
   begin
      Put(To_Wide_String(To_String(Name)));
   end;

   type Asis_Query_Arr is array (1..142) of Asis_Query;

   Asis_Functions : Asis_Query_Arr := (--Asis.Elements (1 Functions)
                                       (Asis.Elements.Enclosing_Element'Access,
                                        To_Bounded_String("Asis.Elements.Enclosing_Element")),

                                       --Asis.Clauses (5 Functions)
                                       (Asis.Clauses.Representation_Clause_Name'Access,
                                        To_Bounded_String("Asis.Clauses.Representation_Clause_Name")),
                                       (Asis.Clauses.Representation_Clause_Expression'Access,
                                        To_Bounded_String("Asis.Clauses.Representation_Clause_Expression")),
                                       (Asis.Clauses.Mod_Clause_Expression'Access,
                                        To_Bounded_String("Asis.Clauses.Mod_Clause_Expression")),
                                       (Asis.Clauses.Component_Clause_Position'Access,
                                        To_Bounded_String("Asis.Clauses.Component_Clause_Position")),
                                       (Asis.Clauses.Component_Clause_Range'Access,
                                        To_Bounded_String("Asis.Clauses.Component_Clause_Range")),

                                       --Asis.Definitions (24 Functions)
                                       (Asis.Definitions.Parent_Subtype_Indication'Access,
                                        To_Bounded_String("Asis.Definitions.Parent_Subtype_Indication")),
                                       (Asis.Definitions.Record_Definition'Access,
                                        To_Bounded_String("Asis.Definitions.Record_Definition")),
                                       (Asis.Definitions.Corresponding_Parent_Subtype'Access,
                                        To_Bounded_String("Asis.Definitions.Corresponding_Parent_Subtype")),
                                       (Asis.Definitions.Corresponding_Root_Type'Access,
                                        To_Bounded_String("Asis.Definitions.Corresponding_Root_Type")),
                                       (Asis.Definitions.Corresponding_Type_Structure'Access,
                                        To_Bounded_String("Asis.Definitions.Corresponding_Type_Structure")),
                                       (Asis.Definitions.Integer_Constraint'Access,
                                        To_Bounded_String("Asis.Definitions.Integer_Constraint")),
                                       (Asis.Definitions.Mod_Static_Expression'Access,
                                        To_Bounded_String("Asis.Definitions.Mod_Static_Expression")),
                                       (Asis.Definitions.Digits_Expression'Access,
                                        To_Bounded_String("Asis.Definitions.Digits_Expression")),
                                       (Asis.Definitions.Delta_Expression'Access,
                                        To_Bounded_String("Asis.Definitions.Delta_Expression")),
                                       (Asis.Definitions.Real_Range_Constraint'Access,
                                        To_Bounded_String("Asis.Definitions.Real_Range_Constraint")),
                                       (Asis.Definitions.Array_Component_Definition'Access,
                                        To_Bounded_String("Asis.Definitions.Array_Component_Definition")),
                                       (Asis.Definitions.Access_To_Object_Definition'Access,
                                        To_Bounded_String("Asis.Definitions.Access_To_Object_Definition")),
                                       (Asis.Definitions.Anonymous_Access_To_Object_Subtype_Mark'Access,
                                        To_Bounded_String("Asis.Definitions.Anonymous_Access_To_Object_Subtype_Mark")),
                                       (Asis.Definitions.Access_To_Function_Result_Profile'Access,
                                        To_Bounded_String("Asis.Definitions.Access_To_Function_Result_Profile")),
                                       (Asis.Definitions.Subtype_Mark'Access,
                                        To_Bounded_String("Asis.Definitions.Subtype_Mark")),
                                       (Asis.Definitions.Subtype_Constraint'Access,
                                        To_Bounded_String("Asis.Definitions.Subtype_Constraint")),
                                       (Asis.Definitions.Lower_Bound'Access,
                                        To_Bounded_String("Asis.Definitions.Lower_Bound")),
                                       (Asis.Definitions.Upper_Bound'Access,
                                        To_Bounded_String("Asis.Definitions.Upper_Bound")),
                                       (Asis.Definitions.Range_Attribute'Access,
                                        To_Bounded_String("Asis.Definitions.Range_Attribute")),
                                       (Asis.Definitions.Component_Subtype_Indication'Access,
                                        To_Bounded_String("Asis.Definitions.Component_Subtype_Indication")),
                                       (Asis.Definitions.Component_Definition_View'Access,
                                        To_Bounded_String("Asis.Definitions.Component_Definition_View")),
                                       (Asis.Definitions.Ancestor_Subtype_Indication'Access,
                                        To_Bounded_String("Asis.Definitions.Ancestor_Subtype_Indication")),
                                       (Asis.Definitions.Aspect_Mark'Access,
                                        To_Bounded_String("Asis.Definitions.Aspect_Mark")),
                                       (Asis.Definitions.Aspect_Definition'Access,
                                        To_Bounded_String("Asis.Definitions.Aspect_Definition")),

                                       --Asis.Declarations (31 Functions)
                                       (Asis.Declarations.Discriminant_Part'Access,
                                        To_Bounded_String("Asis.Declarations.Discriminant_Part")),
                                       (Asis.Declarations.Type_Declaration_View'Access,
                                        To_Bounded_String("Asis.Declarations.Type_Declaration_View")),
                                       (Asis.Declarations.Object_Declaration_View'Access,
                                        To_Bounded_String("Asis.Declarations.Object_Declaration_View")),
                                       (Asis.Declarations.Initialization_Expression'Access,
                                        To_Bounded_String("Asis.Declarations.Initialization_Expression")),
                                       (Asis.Declarations.Corresponding_Constant_Declaration'Access,
                                        To_Bounded_String("Asis.Declarations.Corresponding_Constant_Declaration")),
                                       (Asis.Declarations.Declaration_Subtype_Mark'Access,
                                        To_Bounded_String("Asis.Declarations.Declaration_Subtype_Mark")),
                                       (Asis.Declarations.Corresponding_Type_Declaration'Access,
                                        To_Bounded_String("Asis.Declarations.Corresponding_Type_Declaration")),
                                       (Asis.Declarations.Corresponding_Type_Completion'Access,
                                        To_Bounded_String("Asis.Declarations.Corresponding_Type_Completion")),
                                       (Asis.Declarations.Corresponding_Type_Partial_View'Access,
                                        To_Bounded_String("Asis.Declarations.Corresponding_Type_Partial_View")),
                                       (Asis.Declarations.Corresponding_First_Subtype'Access,
                                        To_Bounded_String("Asis.Declarations.Corresponding_First_Subtype")),
                                       (Asis.Declarations.Corresponding_Last_Subtype'Access,
                                        To_Bounded_String("Asis.Declarations.Corresponding_Last_Subtype")),
                                       (Asis.Declarations.Specification_Subtype_Definition'Access,
                                        To_Bounded_String("Asis.Declarations.Specification_Subtype_Definition")),
                                       (Asis.Declarations.Iteration_Scheme_Name'Access,
                                        To_Bounded_String("Asis.Declarations.Iteration_Scheme_Name")),
                                       (Asis.Declarations.Subtype_Indication'Access,
                                        To_Bounded_String("Asis.Declarations.Subtype_Indication")),
                                       (Asis.Declarations.Result_Profile'Access,
                                        To_Bounded_String("Asis.Declarations.Result_Profile")),
                                       (Asis.Declarations.Result_Expression'Access,
                                        To_Bounded_String("Asis.Declarations.Result_Expression")),
                                       (Asis.Declarations.Body_Block_Statement'Access,
                                        To_Bounded_String("Asis.Declarations.Body_Block_Statement")),
                                       (Asis.Declarations.Corresponding_Declaration'Access,
                                        To_Bounded_String("Asis.Declarations.Corresponding_Declaration")),
                                       (Asis.Declarations.Corresponding_Body'Access,
                                        To_Bounded_String("Asis.Declarations.Corresponding_Body")),
                                       (Asis.Declarations.Corresponding_Subprogram_Derivation'Access,
                                        To_Bounded_String("Asis.Declarations.Corresponding_Subprogram_Derivation")),
                                       (Asis.Declarations.Corresponding_Type'Access,
                                        To_Bounded_String("Asis.Declarations.Corresponding_Type")),
                                       (Asis.Declarations.Corresponding_Equality_Operator'Access,
                                        To_Bounded_String("Asis.Declarations.Corresponding_Equality_Operator")),
                                       (Asis.Declarations.Renamed_Entity'Access,
                                        To_Bounded_String("Asis.Declarations.Renamed_Entity")),
                                       (Asis.Declarations.Corresponding_Base_Entity'Access,
                                        To_Bounded_String("Asis.Declarations.Corresponding_Base_Entity")),
                                       (Asis.Declarations.Entry_Family_Definition'Access,
                                        To_Bounded_String("Asis.Declarations.Entry_Family_Definition")),
                                       (Asis.Declarations.Entry_Index_Specification'Access,
                                        To_Bounded_String("Asis.Declarations.Entry_Index_Specification")),
                                       (Asis.Declarations.Entry_Barrier'Access,
                                        To_Bounded_String("Asis.Declarations.Entry_Barrier")),
                                       (Asis.Declarations.Corresponding_Subunit'Access,
                                        To_Bounded_String("Asis.Declarations.Corresponding_Subunit")),
                                       (Asis.Declarations.Corresponding_Body_Stub'Access,
                                        To_Bounded_String("Asis.Declarations.Corresponding_Body_Stub")),
                                       (Asis.Declarations.Generic_Unit_Name'Access,
                                        To_Bounded_String("Asis.Declarations.Generic_Unit_Name")),
                                       (Asis.Declarations.Corresponding_Generic_Element'Access,
                                        To_Bounded_String("Asis.Declarations.Corresponding_Generic_Element")),

                                       --Asis.Expressions (26 Functions)
                                       (Asis.Expressions.Corresponding_Expression_Type'Access,
                                        To_Bounded_String("Asis.Expressions.Corresponding_Expression_Type")),
                                       (Asis.Expressions.Corresponding_Expression_Type_Definition'Access,
                                        To_Bounded_String("Asis.Expressions.Corresponding_Expression_Type_Definition")),
                                       (Asis.Expressions.Corresponding_Name_Definition'Access,
                                        To_Bounded_String("Asis.Expressions.Corresponding_Name_Definition")),
                                       (Asis.Expressions.Corresponding_Name_Declaration'Access,
                                        To_Bounded_String("Asis.Expressions.Corresponding_Name_Declaration")),
                                       (Asis.Expressions.Prefix'Access,
                                        To_Bounded_String("Asis.Expressions.Prefix")),
                                       (Asis.Expressions.Selector'Access,
                                        To_Bounded_String("Asis.Expressions.Selector")),
                                       (Asis.Expressions.Attribute_Designator_Identifier'Access,
                                        To_Bounded_String("Asis.Expressions.Attribute_Designator_Identifier")),
                                       (Asis.Expressions.Extension_Aggregate_Expression'Access,
                                        To_Bounded_String("Asis.Expressions.Extension_Aggregate_Expression")),
                                       (Asis.Expressions.Component_Expression'Access,
                                        To_Bounded_String("Asis.Expressions.Component_Expression")),
                                       (Asis.Expressions.Formal_Parameter'Access,
                                        To_Bounded_String("Asis.Expressions.Formal_Parameter")),
                                       (Asis.Expressions.Actual_Parameter'Access,
                                        To_Bounded_String("Asis.Expressions.Actual_Parameter")),
                                       (Asis.Expressions.Discriminant_Expression'Access,
                                        To_Bounded_String("Asis.Expressions.Discriminant_Expression")),
                                       (Asis.Expressions.Expression_Parenthesized'Access,
                                        To_Bounded_String("Asis.Expressions.Expression_Parenthesized")),
                                       (Asis.Expressions.Corresponding_Called_Function'Access,
                                        To_Bounded_String("Asis.Expressions.Corresponding_Called_Function")),
                                       (Asis.Expressions.Short_Circuit_Operation_Left_Expression'Access,
                                        To_Bounded_String("Asis.Expressions.Short_Circuit_Operation_Left_Expression")),
                                       (Asis.Expressions.Short_Circuit_Operation_Right_Expression'Access,
                                        To_Bounded_String("Asis.Expressions.Short_Circuit_Operation_Right_Expression")),
                                       (Asis.Expressions.Membership_Test_Expression'Access,
                                        To_Bounded_String("Asis.Expressions.Membership_Test_Expression")),
                                       (Asis.Expressions.Membership_Test_Range'Access,
                                        To_Bounded_String("Asis.Expressions.Membership_Test_Range")),
                                       (Asis.Expressions.Membership_Test_Subtype_Mark'Access,
                                        To_Bounded_String("Asis.Expressions.Membership_Test_Subtype_Mark")),
                                       (Asis.Expressions.Converted_Or_Qualified_Subtype_Mark'Access,
                                        To_Bounded_String("Asis.Expressions.Converted_Or_Qualified_Subtype_Mark")),
                                       (Asis.Expressions.Converted_Or_Qualified_Expression'Access,
                                        To_Bounded_String("Asis.Expressions.Converted_Or_Qualified_Expression")),
                                       (Asis.Expressions.Allocator_Subtype_Indication'Access,
                                        To_Bounded_String("Asis.Expressions.Allocator_Subtype_Indication")),
                                       (Asis.Expressions.Allocator_Qualified_Expression'Access,
                                        To_Bounded_String("Asis.Expressions.Allocator_Qualified_Expression")),
                                       (Asis.Expressions.Dependent_Expression'Access,
                                        To_Bounded_String("Asis.Expressions.Dependent_Expression")),
                                       (Asis.Expressions.Iterator_Specification'Access,
                                        To_Bounded_String("Asis.Expressions.Iterator_Specification")),
                                       (Asis.Expressions.Predicate'Access,
                                        To_Bounded_String("Asis.Expressions.Predicate")),
                                       (Asis.Expressions.Subpool_Name'Access,
                                        To_Bounded_String("Asis.Expressions.Subpool_Name")),

                                        --Asis.Extensions (13 Functions)
                                       (Asis.Extensions.Formal_Subprogram_Default'Access,
                                        To_Bounded_String("Asis.Extensions.Formal_Subprogram_Default")),
                                       (Asis.Extensions.Primitive_Owner'Access,
                                        To_Bounded_String("Asis.Extensions.Primitive_Owner")),
                                       (Asis.Extensions.Corresponding_Called_Function_Unwound'Access,
                                        To_Bounded_String("Asis.Extensions.Corresponding_Called_Function_Unwound")),
                                       (Asis.Extensions.Corresponding_Called_Function_Unwinded'Access,
                                        To_Bounded_String("Asis.Extensions.Corresponding_Called_Function_Unwinded")),
                                       (Asis.Extensions.Corresponding_Called_Entity_Unwound'Access,
                                        To_Bounded_String("Asis.Extensions.Corresponding_Called_Entity_Unwound")),
                                       (Asis.Extensions.Corresponding_Called_Entity_Unwinded'Access,
                                        To_Bounded_String("Asis.Extensions.Corresponding_Called_Entity_Unwinded")),
                                       (Asis.Extensions.First_Name'Access,
                                        To_Bounded_String("Asis.Extensions.First_Name")),
                                       (Asis.Extensions.Corresponding_Overridden_Operation'Access,
                                        To_Bounded_String("Asis.Extensions.Corresponding_Overridden_Operation")),
                                       (Asis.Extensions.Corresponding_Parent_Subtype_Unwind_Base'Access,
                                        To_Bounded_String("Asis.Extensions.Corresponding_Parent_Subtype_Unwind_Base")),
                                       (Asis.Extensions.Normalize_Reference'Access,
                                        To_Bounded_String("Asis.Extensions.Normalize_Reference")),
                                       (Asis.Extensions.Corresponding_First_Definition'Access,
                                        To_Bounded_String("Asis.Extensions.Corresponding_First_Definition")),
                                       (Asis.Extensions.Corresponding_Body_Parameter_Definition'Access,
                                        To_Bounded_String("Asis.Extensions.Corresponding_Body_Parameter_Definition")),
                                       (Asis.Extensions.Get_Last_Component'Access,
                                        To_Bounded_String("Asis.Extensions.Get_Last_Component")),

                                       --Asis.Statements (27 Functions)
                                       (Asis.Statements.Assignment_Variable_Name'Access,
                                        To_Bounded_String("Asis.Statements.Assignment_Variable_Name")),
                                       (Asis.Statements.Assignment_Expression'Access,
                                        To_Bounded_String("Asis.Statements.Assignment_Expression")),
                                       (Asis.Statements.Condition_Expression'Access,
                                        To_Bounded_String("Asis.Statements.Condition_Expression")),
                                       (Asis.Statements.Case_Expression'Access,
                                        To_Bounded_String("Asis.Statements.Case_Expression")),
                                       (Asis.Statements.Statement_Identifier'Access,
                                        To_Bounded_String("Asis.Statements.Statement_Identifier")),
                                       (Asis.Statements.While_Condition'Access,
                                        To_Bounded_String("Asis.Statements.While_Condition")),
                                       (Asis.Statements.For_Loop_Parameter_Specification'Access,
                                        To_Bounded_String("Asis.Statements.For_Loop_Parameter_Specification")),
                                       (Asis.Statements.Exit_Loop_Name'Access,
                                        To_Bounded_String("Asis.Statements.Exit_Loop_Name")),
                                       (Asis.Statements.Exit_Condition'Access,
                                        To_Bounded_String("Asis.Statements.Exit_Condition")),
                                       (Asis.Statements.Corresponding_Loop_Exited'Access,
                                        To_Bounded_String("Asis.Statements.Corresponding_Loop_Exited")),
                                       (Asis.Statements.Return_Expression'Access,
                                        To_Bounded_String("Asis.Statements.Return_Expression")),
                                       (Asis.Statements.Return_Object_Declaration'Access,
                                        To_Bounded_String("Asis.Statements.Return_Object_Declaration")),
                                       (Asis.Statements.Goto_Label'Access,
                                        To_Bounded_String("Asis.Statements.Goto_Label")),
                                       (Asis.Statements.Corresponding_Destination_Statement'Access,
                                        To_Bounded_String("Asis.Statements.Corresponding_Destination_Statement")),
                                       (Asis.Statements.Called_Name'Access,
                                        To_Bounded_String("Asis.Statements.Called_Name")),
                                       (Asis.Statements.Corresponding_Called_Entity'Access,
                                        To_Bounded_String("Asis.Statements.Corresponding_Called_Entity")),
                                       (Asis.Statements.Accept_Entry_Index'Access,
                                        To_Bounded_String("Asis.Statements.Accept_Entry_Index")),
                                       (Asis.Statements.Accept_Entry_Direct_Name'Access,
                                        To_Bounded_String("Asis.Statements.Accept_Entry_Direct_Name")),
                                       (Asis.Statements.Corresponding_Entry'Access,
                                        To_Bounded_String("Asis.Statements.Corresponding_Entry")),
                                       (Asis.Statements.Requeue_Entry_Name'Access,
                                        To_Bounded_String("Asis.Statements.Requeue_Entry_Name")),
                                       (Asis.Statements.Delay_Expression'Access,
                                        To_Bounded_String("Asis.Statements.Delay_Expression")),
                                       (Asis.Statements.Guard'Access,
                                        To_Bounded_String("Asis.Statements.Guard")),
                                       (Asis.Statements.Choice_Parameter_Specification'Access,
                                        To_Bounded_String("Asis.Statements.Choice_Parameter_Specification")),
                                       (Asis.Statements.Raised_Exception'Access,
                                        To_Bounded_String("Asis.Statements.Raised_Exception")),
                                       (Asis.Statements.Associated_Message'Access,
                                        To_Bounded_String("Asis.Statements.Associated_Message")),
                                       (Asis.Statements.Qualified_Expression'Access,
                                        To_Bounded_String("Asis.Statements.Qualified_Expression")),

                                       --Thick_Queries (15 functions)
                                       (Thick_Queries.Ultimate_Enclosing_Instantiation'Access,
                                        To_Bounded_String("Thick_Queries.Ultimate_Enclosing_Instantiation")),
                                       (Thick_Queries.Subtype_Simple_Name'Access,
                                        To_Bounded_String("Thick_Queries.Subtype_Simple_Name")),
                                       (Thick_Queries.First_Subtype_Name'Access,
                                        To_Bounded_String("Thick_Queries.First_Subtype_Name")),
                                       (Thick_Queries.Access_Target_Type'Access,
                                        To_Bounded_String("Thick_Queries.Access_Target_Type")),
                                       (Thick_Queries.Corresponding_Component_Clause'Access,
                                        To_Bounded_String("Thick_Queries.Corresponding_Component_Clause")),
                                       (Thick_Queries.Corresponding_Enumeration_Clause'Access,
                                        To_Bounded_String("Thick_Queries.Corresponding_Enumeration_Clause")),
                                       (Thick_Queries.Simple_Name'Access,
                                        To_Bounded_String("Thick_Queries.Simple_Name")),
                                       (Thick_Queries.Strip_Attributes'Access,
                                        To_Bounded_String("Thick_Queries.Strip_Attributes")),
                                       (Thick_Queries.First_Defining_Name'Access,
                                        To_Bounded_String("Thick_Queries.First_Defining_Name")),
                                       (Thick_Queries.Ultimate_Expression'Access,
                                        To_Bounded_String("Thick_Queries.Ultimate_Expression")),
                                       (Thick_Queries.Corresponding_Expression_Type_Definition'Access,
                                        To_Bounded_String("Thick_Queries.Corresponding_Expression_Type_Definition")),
                                       (Thick_Queries.Ultimate_Expression_Type'Access,
                                        To_Bounded_String("Thick_Queries.Ultimate_Expression_Type")),
                                       (Thick_Queries.Called_Simple_Name'Access,
                                        To_Bounded_String("Thick_Queries.Called_Simple_Name")),
                                       (Thick_Queries.Formal_Name'Access,
                                        To_Bounded_String("Thick_Queries.Formal_Name")),
                                       (Thick_Queries.External_Call_Target'Access,
                                        To_Bounded_String("Thick_Queries.External_Call_Target"))
                                       );

   subtype String_Type is Wide_String;
   CONTEXT_UNIT_NOT_FOUND_MESSAGE : constant String_Type := "Context does not contain the requested unit: ";
   CONTEXT_UNIT_FOUND_MESSAGE : constant String_Type := "Context contains the requested unit: ";
   STATUS_VALUE_MESSAGE : constant String_Type := "Status Value is ";

   My_Context              : Asis.Context;
   My_Unit                    : Asis.Compilation_Unit;
   Unit_Name                  : Wide_String ( 1 .. 100 );
   Unit_Name_Length           : Natural;
   Path_Name                  : Wide_String ( 1 .. 100 );
   Path_Name_Length           : Natural;

   procedure Pre_Procedure
     (Element   : in     Asis.Element;
      Control   : in out Asis.Traverse_Control;
      State     : in out Boolean);

   procedure Post_Procedure
     (Element   : in     Asis.Element;
      Control   : in out Asis.Traverse_Control;
      State     : in out Boolean);

   procedure Traverse_Tree is new
     Asis.Iterator.Traverse_Element
       (Boolean, Pre_Procedure, Post_Procedure);

   procedure Pre_Procedure (Element : in Asis.Element;
                            Control    : in out Asis.Traverse_Control;
                            State      : in out Boolean) is
      use Asis, Asis.Elements, Asis.Expressions, Asis.Text;
      use Ada.Strings, Ada.Strings.Wide_Fixed;
      use Utilities;

      Result : Asis.Element;
      Arg_Span : Span := Element_Span(Element);
      Res_Span : Span;
   begin -- Pre_Procedure

      Put_Line(--Unit_Name(1 .. Unit_Name_Length) & ":" &
               "<<< " &
               Trim(Natural'Wide_Image(Arg_Span.First_Line),Both) & ":" &
               Trim(Natural'Wide_Image(Arg_Span.First_Column), Both) & ":");
      Put_Line(Trim(Element_Image(Element), Both));

      for I in Asis_Query_Arr'Range loop
         begin
            Result := Asis_Functions(I).Call(Element);
            if Element_Kind(Result) /= Not_An_Element then
               Res_Span := Element_Span(Result);
               New_Line;
               Put(--Unit_Name(1 .. Unit_Name_Length) & ":" &
                   ">>> " &
                   Trim(Natural'Wide_Image(Res_Span.First_Line),Both) & ":" &
                   Trim(Natural'Wide_Image(Res_Span.First_Column), Both) & ": --- ");
               Display(Asis_Functions(I).Name);
               New_Line;
               Put_Line(Trim(Element_Image(Result), Both));
            end if;
         exception
            when Ex : others =>
               null;
         end;
      end loop;

      Put_Line("---------------------------------------------------------");
   end Pre_Procedure;

   procedure Post_Procedure (Element : in Asis.Element;
                             Control    : in out Asis.Traverse_Control;
                             State      : in out Boolean) is
      use Asis, Asis.Elements, Asis.Expressions;
      use Utilities;
   begin -- Post_Procedure
     null;
   end Post_Procedure;

   procedure Process_Unit (Unit : in Asis.Compilation_Unit) is
      use Ada.Characters.Handling;
      Control : Asis.Traverse_Control := Asis.Continue;
      State   : Boolean := True;

   begin

      case Asis.Compilation_Units.Unit_Origin (Unit) is
         when Asis.An_Application_Unit =>
            Put_Line ("Processing Unit: " &
                      Asis.Compilation_Units.Unit_Full_Name(Unit));
            New_Line;
            Traverse_Tree (Asis.Elements.Unit_Declaration(Unit), Control, State);
         when others =>
            null;
      end case;

   end Process_Unit;

begin -- Rorg_Analysis

   Asis.Implementation.Initialize;
   --Asis.Ada_Environments.Associate (My_Context, "My Context");

   --Flags: -CA -FS -I<dir>
   -- FS: All the trees considered as making up a given Context are created
   --   "on the fly", whether or not the corresponding tree file already exists.
   --   Once created, a tree file then is reused as long as the Context remains open.
   -- CA: The Context comprises all the tree files in the tree search path.
   --   ASIS processes all the tree files located in the tree search path
   --   associated with the Context.
   -- I<dir>: Defines the directory in which to search for source files
   -- when compiling sources to create a tree "on the fly".
   --TODO: don't include adatest path
   Context_Arguments.Initialize;
   Context_Arguments.Get_Path_Name(Path_Name, Path_Name_Length);
   Context_Arguments.Get_Unit_Name(Unit_Name, Unit_Name_Length);

   Asis.Ada_Environments.Associate (My_Context, "My Context",
                                    "-CA -FS -I"&Path_Name(1..Path_Name_Length));
   Asis.Ada_Environments.Open (My_Context);

   --if Unit_Name_Length=0 then
   --   Put_Line ("Type the name of an Ada package specification");
   --   Get_Line (Unit_Name, Unit_Name_Length);
   --end if;

   --ASIS first tries to locate the source file 'Unit_Name' in the current
   --directory: '.'. If there is no such file in the currect directory. If
   --there is no such file in the current directory, ASIS continues the search
   --by looking into the directories listed in the value of ADA_INCLUDE_PATH
   --environment variable. If the source is found (say in the current
   --directory), ASIS creates the tree file by calling the compiler:
   -- $ gcc -c -gnatc -gnatt -I. -I- 'Unit_Name'.ads
   My_Unit := Asis.Compilation_Units.Compilation_Unit_Body
     ( Unit_Name ( 1 .. Unit_Name_Length), My_Context );

   if Asis.Compilation_Units.Is_Nil ( My_Unit )
   then
      Put (CONTEXT_UNIT_NOT_FOUND_MESSAGE);
      Put (Unit_Name ( 1 .. Unit_Name_Length));
      New_Line;
   else
      Put (CONTEXT_UNIT_FOUND_MESSAGE);
      Put (Unit_Name ( 1 .. Unit_Name_Length));
      New_Line;
      Process_Unit(My_Unit);
      --Post_Process_Unit;
      New_Line;
   end if;

   My_Unit := Asis.Compilation_Units.Library_Unit_Declaration
     ( Unit_Name ( 1 .. Unit_Name_Length), My_Context );

   if not Asis.Compilation_Units.Is_Nil ( My_Unit ) then
      Put (CONTEXT_UNIT_FOUND_MESSAGE);
      Put (Unit_Name ( 1 .. Unit_Name_Length));
      New_Line;
      Process_Unit(My_Unit);
      --Post_Process_Unit;
      New_Line;
   end if;

   Asis.Ada_Environments.Close (My_Context);
   Asis.Ada_Environments.Dissociate (My_Context);
   Asis.Implementation.Finalize;

exception

   when Asis.Exceptions.ASIS_Inappropriate_Context
      | Asis.Exceptions.ASIS_Inappropriate_Container
      | Asis.Exceptions.ASIS_Inappropriate_Compilation_Unit
      | Asis.Exceptions.ASIS_Inappropriate_Element
      | Asis.Exceptions.ASIS_Inappropriate_Line
      | Asis.Exceptions.ASIS_Inappropriate_Line_Number
      | Asis.Exceptions.ASIS_Failed
      =>

      Put (Asis.Implementation.Diagnosis);
      New_Line;
      Put (STATUS_VALUE_MESSAGE);
      Put (Asis.Errors.Error_Kinds'Wide_Image
           (Asis.Implementation.Status));
      New_Line;

   when others =>

      Put_Line ("Asis Application failed because of non-ASIS reasons");

end Element_Processing;
