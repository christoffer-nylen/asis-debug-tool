-- ADA
with
  Ada.Text_Io,
  Ada.Wide_Text_Io,
  Ada.Characters.Handling,
  Ada.Command_Line,
  Ada.Strings.Bounded,
  Ada.Strings,
  Ada.Strings.Wide_Fixed,
  Ada.Unchecked_Conversion;
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

   type Access_Element_In_Context_Out is access function (Element : Asis.Element) return Asis.Context;
   type Access_Element_In_Element_Out is access function (Element : Asis.Element) return Asis.Element;
   type Access_Element_In_Element_List_Out is access function (Element : Asis.Element) return Asis.Element_List;
   type Access_Element_In_Compilation_Unit_Out is access function (Element : Asis.Element) return Asis.Compilation_Unit;
   type Access_Element_In_Compilation_Unit_List_Out is access function (Element : Asis.Element) return Asis.Compilation_Unit_List;

   type Function_Return_Type is (A_Context,
                                 An_Element,
                                 An_Element_List,
                                 A_Compilation_Unit,
                                 A_Compilation_Unit_List);

   type Access_Function_Multi_Element (Kind : Function_Return_Type := An_Element) is
      record
         Option : Function_Return_Type;
         case Kind is
            when A_Context =>
               Context : Access_Element_In_Context_Out;
            when An_Element =>
               Element : Access_Element_In_Element_Out;
            when An_Element_List =>
               Element_List : Access_Element_In_Element_List_Out;
            when A_Compilation_Unit =>
               Compilation_Unit : Access_Element_In_Compilation_Unit_Out;
            when A_Compilation_Unit_List =>
               Compilation_Unit_List : Access_Element_In_Compilation_Unit_List_Out;
         end case;
      end record;

   package My_Strings is new Ada.Strings.Bounded.Generic_Bounded_Length(100);
   use My_Strings;

   type Asis_Query is
      record
         Call : Access_Function_Multi_Element;
         Name : BOUNDED_STRING;
      end record;

   --type Asis_Query_Arr is array (Integer range <>) of Asis_Query;

   Asis_Functions : array (Integer range <>) of Asis_Query
     := (--Asis.Elements
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Elements.Enclosing_Element'Access),
          To_Bounded_String("Asis.Elements.Enclosing_Element")),
         ((Kind => An_Element_List,
           Option => An_Element_List,
           Element_List => Asis.Elements.Pragmas'Access),
          To_Bounded_String("Asis.Elements.Pragmas")),
         ((Kind => An_Element_List,
           Option => An_Element_List,
           Element_List => Asis.Elements.Corresponding_Pragmas'Access),
          To_Bounded_String("Asis.Elements.Corresponding_Pragmas")),
         ((Kind => An_Element_List,
           Option => An_Element_List,
           Element_List => Asis.Elements.Pragma_Argument_Associations'Access),
          To_Bounded_String("Asis.Elements.Pragma_Argument_Associations")),

         --Asis.Clauses
         ((Kind => An_Element_List,
           Option => An_Element_List,
           Element_List => Asis.Clauses.Clause_Names'Access),
          To_Bounded_String("Asis.Clauses.Clause_Names")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Clauses.Representation_Clause_Name'Access),
          To_Bounded_String("Asis.Clauses.Representation_Clause_Name")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Clauses.Representation_Clause_Expression'Access),
          To_Bounded_String("Asis.Clauses.Representation_Clause_Expression")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Clauses.Mod_Clause_Expression'Access),
          To_Bounded_String("Asis.Clauses.Mod_Clause_Expression")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Clauses.Component_Clause_Position'Access),
          To_Bounded_String("Asis.Clauses.Component_Clause_Position")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Clauses.Component_Clause_Range'Access),
          To_Bounded_String("Asis.Clauses.Component_Clause_Range")),

         --Asis.Definitions
         ((Kind => An_Element_List,
           Option => An_Element_List,
           Element_List => Asis.Definitions.Corresponding_Type_Operators'Access),
          To_Bounded_String("Asis.Definitions.Corresponding_Type_Operators")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Definitions.Parent_Subtype_Indication'Access),
          To_Bounded_String("Asis.Definitions.Parent_Subtype_Indication")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Definitions.Record_Definition'Access),
          To_Bounded_String("Asis.Definitions.Record_Definition")),
         ((Kind => An_Element_List,
           Option => An_Element_List,
           Element_List => Asis.Definitions.Implicit_Inherited_Declarations'Access),
          To_Bounded_String("Asis.Definitions.Implicit_Inherited_Declarations")),
         ((Kind => An_Element_List,
           Option => An_Element_List,
           Element_List => Asis.Definitions.Implicit_Inherited_Subprograms'Access),
          To_Bounded_String("Asis.Definitions.Implicit_Inherited_Subprograms")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Definitions.Corresponding_Parent_Subtype'Access),
          To_Bounded_String("Asis.Definitions.Corresponding_Parent_Subtype")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Definitions.Corresponding_Root_Type'Access),
          To_Bounded_String("Asis.Definitions.Corresponding_Root_Type")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Definitions.Corresponding_Type_Structure'Access),
          To_Bounded_String("Asis.Definitions.Corresponding_Type_Structure")),
         ((Kind => An_Element_List,
           Option => An_Element_List,
           Element_List => Asis.Definitions.Enumeration_Literal_Declarations'Access),
          To_Bounded_String("Asis.Definitions.Enumeration_Literal_Declarations")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Definitions.Integer_Constraint'Access),
          To_Bounded_String("Asis.Definitions.Integer_Constraint")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Definitions.Mod_Static_Expression'Access),
          To_Bounded_String("Asis.Definitions.Mod_Static_Expression")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Definitions.Digits_Expression'Access),
          To_Bounded_String("Asis.Definitions.Digits_Expression")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Definitions.Delta_Expression'Access),
          To_Bounded_String("Asis.Definitions.Delta_Expression")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Definitions.Real_Range_Constraint'Access),
          To_Bounded_String("Asis.Definitions.Real_Range_Constraint")),
         ((Kind => An_Element_List,
           Option => An_Element_List,
           Element_List => Asis.Definitions.Index_Subtype_Definitions'Access),
          To_Bounded_String("Asis.Definitions.Index_Subtype_Definitions")),
         ((Kind => An_Element_List,
           Option => An_Element_List,
           Element_List => Asis.Definitions.Discrete_Subtype_Definitions'Access),
          To_Bounded_String("Asis.Definitions.Discrete_Subtype_Definitions")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Definitions.Array_Component_Definition'Access),
          To_Bounded_String("Asis.Definitions.Array_Component_Definition")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Definitions.Access_To_Object_Definition'Access),
          To_Bounded_String("Asis.Definitions.Access_To_Object_Definition")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Definitions.Anonymous_Access_To_Object_Subtype_Mark'Access),
          To_Bounded_String("Asis.Definitions.Anonymous_Access_To_Object_Subtype_Mark")),
         ((Kind => An_Element_List,
           Option => An_Element_List,
           Element_List => Asis.Definitions.Access_To_Subprogram_Parameter_Profile'Access),
          To_Bounded_String("Asis.Definitions.Access_To_Subprogram_Parameter_Profile")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Definitions.Access_To_Function_Result_Profile'Access),
          To_Bounded_String("Asis.Definitions.Access_To_Function_Result_Profile")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Definitions.Subtype_Mark'Access),
          To_Bounded_String("Asis.Definitions.Subtype_Mark")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Definitions.Subtype_Constraint'Access),
          To_Bounded_String("Asis.Definitions.Subtype_Constraint")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Definitions.Lower_Bound'Access),
          To_Bounded_String("Asis.Definitions.Lower_Bound")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Definitions.Upper_Bound'Access),
          To_Bounded_String("Asis.Definitions.Upper_Bound")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Definitions.Range_Attribute'Access),
          To_Bounded_String("Asis.Definitions.Range_Attribute")),
         ((Kind => An_Element_List,
           Option => An_Element_List,
           Element_List => Asis.Definitions.Discrete_Ranges'Access),
          To_Bounded_String("Asis.Definitions.Discrete_Ranges")),
         --((Kind => List,
         --  Option => List,
         --  Element_List => Asis.Definitions.Discriminant_Associations'Access),
         -- To_Bounded_String("Asis.Definitions.Discriminant_Associations")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Definitions.Component_Subtype_Indication'Access),
          To_Bounded_String("Asis.Definitions.Component_Subtype_Indication")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Definitions.Component_Definition_View'Access),
          To_Bounded_String("Asis.Definitions.Component_Definition_View")),
         ((Kind => An_Element_List,
           Option => An_Element_List,
           Element_List => Asis.Definitions.Discriminants'Access),
          To_Bounded_String("Asis.Definitions.Discriminants")),
         --((Kind => List,
         --  Option => List,
         --  Element_List => Asis.Definitions.Record_Components'Access),
         -- To_Bounded_String("Asis.Definitions.Record_Components")),
         ((Kind => An_Element_List,
           Option => An_Element_List,
           Element_List => Asis.Definitions.Implicit_Components'Access),
          To_Bounded_String("Asis.Definitions.Implicit_Components")),
         --((Kind => List,
         --  Option => List,
         --  Element_List => Asis.Definitions.Variants'Access),
         -- To_Bounded_String("Asis.Definitions.Variants")),
         ((Kind => An_Element_List,
           Option => An_Element_List,
           Element_List => Asis.Definitions.Variant_Choices'Access),
          To_Bounded_String("Asis.Definitions.Variant_Choices")),
         ((Kind => An_Element_List,
           Option => An_Element_List,
           Element_List => Asis.Definitions.Definition_Interface_List'Access),
          To_Bounded_String("Asis.Definitions.Definition_Interface_List")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Definitions.Ancestor_Subtype_Indication'Access),
          To_Bounded_String("Asis.Definitions.Ancestor_Subtype_Indication")),
         --((Kind => List,
         --  Option => List,
         --  Element_List => Asis.Definitions.Visible_Part_Items'Access),
         -- To_Bounded_String("Asis.Definitions.Visible_Part_Items")),
         --((Kind => List,
         --  Option => List,
         --  Element_List => Asis.Definitions.Private_Part_Items'Access),
         -- To_Bounded_String("Asis.Definitions.Private_Part_Items")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Definitions.Aspect_Mark'Access),
          To_Bounded_String("Asis.Definitions.Aspect_Mark")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Definitions.Aspect_Definition'Access),
          To_Bounded_String("Asis.Definitions.Aspect_Definition")),

         --Asis.Declarations
         ((Kind => An_Element_List,
           Option => An_Element_List,
           Element_List => Asis.Declarations.Names'Access),
          To_Bounded_String("Asis.Declarations.Names")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Discriminant_Part'Access),
          To_Bounded_String("Asis.Declarations.Discriminant_Part")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Type_Declaration_View'Access),
          To_Bounded_String("Asis.Declarations.Type_Declaration_View")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Object_Declaration_View'Access),
          To_Bounded_String("Asis.Declarations.Object_Declaration_View")),
         ((Kind => An_Element_List,
           Option => An_Element_List,
           Element_List => Asis.Declarations.Aspect_Specifications'Access),
          To_Bounded_String("Asis.Declarations.Aspect_Specifications")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Initialization_Expression'Access),
          To_Bounded_String("Asis.Declarations.Initialization_Expression")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Corresponding_Constant_Declaration'Access),
          To_Bounded_String("Asis.Declarations.Corresponding_Constant_Declaration")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Declaration_Subtype_Mark'Access),
          To_Bounded_String("Asis.Declarations.Declaration_Subtype_Mark")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Corresponding_Type_Declaration'Access),
          To_Bounded_String("Asis.Declarations.Corresponding_Type_Declaration")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Corresponding_Type_Completion'Access),
          To_Bounded_String("Asis.Declarations.Corresponding_Type_Completion")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Corresponding_Type_Partial_View'Access),
          To_Bounded_String("Asis.Declarations.Corresponding_Type_Partial_View")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Corresponding_First_Subtype'Access),
          To_Bounded_String("Asis.Declarations.Corresponding_First_Subtype")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Corresponding_Last_Subtype'Access),
          To_Bounded_String("Asis.Declarations.Corresponding_Last_Subtype")),
         ((Kind => An_Element_List,
           Option => An_Element_List,
           Element_List => Asis.Declarations.Corresponding_Representation_Clauses'Access),
          To_Bounded_String("Asis.Declarations.Corresponding_Representation_Clauses")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Specification_Subtype_Definition'Access),
          To_Bounded_String("Asis.Declarations.Specification_Subtype_Definition")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Iteration_Scheme_Name'Access),
          To_Bounded_String("Asis.Declarations.Iteration_Scheme_Name")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Subtype_Indication'Access),
          To_Bounded_String("Asis.Declarations.Subtype_Indication")),
         ((Kind => An_Element_List,
           Option => An_Element_List,
           Element_List => Asis.Declarations.Parameter_Profile'Access),
          To_Bounded_String("Asis.Declarations.Parameter_Profile")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Result_Profile'Access),
          To_Bounded_String("Asis.Declarations.Result_Profile")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Result_Expression'Access),
          To_Bounded_String("Asis.Declarations.Result_Expression")),
         --((Kind => List,
         --  Option => List,
         --  Element_List => Asis.Declarations.Body_Declarative_Items'Access),
         -- To_Bounded_String("Asis.Declarations.Body_Declarative_Items")),
         --((Kind => List,
         --  Option => List,
         --  Element_List => Asis.Declarations.Body_Statements'Access),
         -- To_Bounded_String("Asis.Declarations.Body_Statements")),
         --((Kind => List,
         --  Option => List,
         --  Element_List => Asis.Declarations.Body_Exception_Handlers'Access),
         -- To_Bounded_String("Asis.Declarations.Body_Exception_Handlers")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Body_Block_Statement'Access),
          To_Bounded_String("Asis.Declarations.Body_Block_Statement")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Corresponding_Declaration'Access),
          To_Bounded_String("Asis.Declarations.Corresponding_Declaration")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Corresponding_Body'Access),
          To_Bounded_String("Asis.Declarations.Corresponding_Body")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Corresponding_Subprogram_Derivation'Access),
          To_Bounded_String("Asis.Declarations.Corresponding_Subprogram_Derivation")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Corresponding_Type'Access),
          To_Bounded_String("Asis.Declarations.Corresponding_Type")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Corresponding_Equality_Operator'Access),
          To_Bounded_String("Asis.Declarations.Corresponding_Equality_Operator")),
         --((Kind => List,
         --  Option => List,
          -- Element_List => Asis.Declarations.Visible_Part_Declarative_Items'Access),
          --To_Bounded_String("Asis.Declarations.Visible_Part_Declarative_Items")),
         --((Kind => List,
         --  Option => List,
         --  Element_List => Asis.Declarations.Private_Part_Declarative_Items'Access),
         -- To_Bounded_String("Asis.Declarations.Private_Part_Declarative_Items")),
         ((Kind => An_Element_List,
           Option => An_Element_List,
           Element_List => Asis.Declarations.Declaration_Interface_List'Access),
          To_Bounded_String("Asis.Declarations.Declaration_Interface_List")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Renamed_Entity'Access),
          To_Bounded_String("Asis.Declarations.Renamed_Entity")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Corresponding_Base_Entity'Access),
          To_Bounded_String("Asis.Declarations.Corresponding_Base_Entity")),
         --((Kind => List,
         --  Option => List,
         --  Element_List => Asis.Declarations.Protected_Operation_Items'Access),
         -- To_Bounded_String("Asis.Declarations.Protected_Operation_Items")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Entry_Family_Definition'Access),
          To_Bounded_String("Asis.Declarations.Entry_Family_Definition")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Entry_Index_Specification'Access),
          To_Bounded_String("Asis.Declarations.Entry_Index_Specification")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Entry_Barrier'Access),
          To_Bounded_String("Asis.Declarations.Entry_Barrier")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Corresponding_Subunit'Access),
          To_Bounded_String("Asis.Declarations.Corresponding_Subunit")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Corresponding_Body_Stub'Access),
          To_Bounded_String("Asis.Declarations.Corresponding_Body_Stub")),
         --((Kind => List,
         --  Option => List,
         --  Element_List => Asis.Declarations.Generic_Formal_Part'Access),
         -- To_Bounded_String("Asis.Declarations.Generic_Formal_Part")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Generic_Unit_Name'Access),
          To_Bounded_String("Asis.Declarations.Generic_Unit_Name")),
         --((Kind => List,
         --  Option => List,
         --  Element_List => Asis.Declarations.Generic_Actual_Part'Access),
         -- To_Bounded_String("Asis.Declarations.Generic_Actual_Part")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Declarations.Corresponding_Generic_Element'Access),
          To_Bounded_String("Asis.Declarations.Corresponding_Generic_Element")),

         --Asis.Expressions
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Corresponding_Expression_Type'Access),
          To_Bounded_String("Asis.Expressions.Corresponding_Expression_Type")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Corresponding_Expression_Type_Definition'Access),
          To_Bounded_String("Asis.Expressions.Corresponding_Expression_Type_Definition")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Corresponding_Name_Definition'Access),
          To_Bounded_String("Asis.Expressions.Corresponding_Name_Definition")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Corresponding_Name_Declaration'Access),
          To_Bounded_String("Asis.Expressions.Corresponding_Name_Declaration")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Prefix'Access),
          To_Bounded_String("Asis.Expressions.Prefix")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Selector'Access),
          To_Bounded_String("Asis.Expressions.Selector")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Attribute_Designator_Identifier'Access),
          To_Bounded_String("Asis.Expressions.Attribute_Designator_Identifier")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Extension_Aggregate_Expression'Access),
          To_Bounded_String("Asis.Expressions.Extension_Aggregate_Expression")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Component_Expression'Access),
          To_Bounded_String("Asis.Expressions.Component_Expression")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Formal_Parameter'Access),
          To_Bounded_String("Asis.Expressions.Formal_Parameter")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Actual_Parameter'Access),
          To_Bounded_String("Asis.Expressions.Actual_Parameter")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Discriminant_Expression'Access),
          To_Bounded_String("Asis.Expressions.Discriminant_Expression")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Expression_Parenthesized'Access),
          To_Bounded_String("Asis.Expressions.Expression_Parenthesized")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Corresponding_Called_Function'Access),
          To_Bounded_String("Asis.Expressions.Corresponding_Called_Function")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Short_Circuit_Operation_Left_Expression'Access),
          To_Bounded_String("Asis.Expressions.Short_Circuit_Operation_Left_Expression")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Short_Circuit_Operation_Right_Expression'Access),
          To_Bounded_String("Asis.Expressions.Short_Circuit_Operation_Right_Expression")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Membership_Test_Expression'Access),
          To_Bounded_String("Asis.Expressions.Membership_Test_Expression")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Membership_Test_Range'Access),
          To_Bounded_String("Asis.Expressions.Membership_Test_Range")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Membership_Test_Subtype_Mark'Access),
          To_Bounded_String("Asis.Expressions.Membership_Test_Subtype_Mark")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Converted_Or_Qualified_Subtype_Mark'Access),
          To_Bounded_String("Asis.Expressions.Converted_Or_Qualified_Subtype_Mark")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Converted_Or_Qualified_Expression'Access),
          To_Bounded_String("Asis.Expressions.Converted_Or_Qualified_Expression")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Allocator_Subtype_Indication'Access),
          To_Bounded_String("Asis.Expressions.Allocator_Subtype_Indication")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Allocator_Qualified_Expression'Access),
          To_Bounded_String("Asis.Expressions.Allocator_Qualified_Expression")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Dependent_Expression'Access),
          To_Bounded_String("Asis.Expressions.Dependent_Expression")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Iterator_Specification'Access),
          To_Bounded_String("Asis.Expressions.Iterator_Specification")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Predicate'Access),
          To_Bounded_String("Asis.Expressions.Predicate")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Expressions.Subpool_Name'Access),
          To_Bounded_String("Asis.Expressions.Subpool_Name")),

         --Asis.Extensions
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Extensions.Formal_Subprogram_Default'Access),
          To_Bounded_String("Asis.Extensions.Formal_Subprogram_Default")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Extensions.Primitive_Owner'Access),
          To_Bounded_String("Asis.Extensions.Primitive_Owner")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Extensions.Corresponding_Called_Function_Unwound'Access),
          To_Bounded_String("Asis.Extensions.Corresponding_Called_Function_Unwound")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Extensions.Corresponding_Called_Function_Unwinded'Access),
          To_Bounded_String("Asis.Extensions.Corresponding_Called_Function_Unwinded")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Extensions.Corresponding_Called_Entity_Unwound'Access),
          To_Bounded_String("Asis.Extensions.Corresponding_Called_Entity_Unwound")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Extensions.Corresponding_Called_Entity_Unwinded'Access),
          To_Bounded_String("Asis.Extensions.Corresponding_Called_Entity_Unwinded")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Extensions.First_Name'Access),
          To_Bounded_String("Asis.Extensions.First_Name")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Extensions.Corresponding_Overridden_Operation'Access),
          To_Bounded_String("Asis.Extensions.Corresponding_Overridden_Operation")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Extensions.Corresponding_Parent_Subtype_Unwind_Base'Access),
          To_Bounded_String("Asis.Extensions.Corresponding_Parent_Subtype_Unwind_Base")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Extensions.Normalize_Reference'Access),
          To_Bounded_String("Asis.Extensions.Normalize_Reference")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Extensions.Corresponding_First_Definition'Access),
          To_Bounded_String("Asis.Extensions.Corresponding_First_Definition")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Extensions.Corresponding_Body_Parameter_Definition'Access),
          To_Bounded_String("Asis.Extensions.Corresponding_Body_Parameter_Definition")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Extensions.Get_Last_Component'Access),
          To_Bounded_String("Asis.Extensions.Get_Last_Component")),

         --Asis.Statements
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.Assignment_Variable_Name'Access),
          To_Bounded_String("Asis.Statements.Assignment_Variable_Name")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.Assignment_Expression'Access),
          To_Bounded_String("Asis.Statements.Assignment_Expression")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.Condition_Expression'Access),
          To_Bounded_String("Asis.Statements.Condition_Expression")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.Case_Expression'Access),
          To_Bounded_String("Asis.Statements.Case_Expression")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.Statement_Identifier'Access),
          To_Bounded_String("Asis.Statements.Statement_Identifier")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.While_Condition'Access),
          To_Bounded_String("Asis.Statements.While_Condition")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.For_Loop_Parameter_Specification'Access),
          To_Bounded_String("Asis.Statements.For_Loop_Parameter_Specification")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.Exit_Loop_Name'Access),
          To_Bounded_String("Asis.Statements.Exit_Loop_Name")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.Exit_Condition'Access),
          To_Bounded_String("Asis.Statements.Exit_Condition")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.Corresponding_Loop_Exited'Access),
          To_Bounded_String("Asis.Statements.Corresponding_Loop_Exited")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.Return_Expression'Access),
          To_Bounded_String("Asis.Statements.Return_Expression")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.Return_Object_Declaration'Access),
          To_Bounded_String("Asis.Statements.Return_Object_Declaration")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.Goto_Label'Access),
          To_Bounded_String("Asis.Statements.Goto_Label")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.Corresponding_Destination_Statement'Access),
          To_Bounded_String("Asis.Statements.Corresponding_Destination_Statement")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.Called_Name'Access),
          To_Bounded_String("Asis.Statements.Called_Name")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.Corresponding_Called_Entity'Access),
          To_Bounded_String("Asis.Statements.Corresponding_Called_Entity")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.Accept_Entry_Index'Access),
          To_Bounded_String("Asis.Statements.Accept_Entry_Index")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.Accept_Entry_Direct_Name'Access),
          To_Bounded_String("Asis.Statements.Accept_Entry_Direct_Name")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.Corresponding_Entry'Access),
          To_Bounded_String("Asis.Statements.Corresponding_Entry")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.Requeue_Entry_Name'Access),
          To_Bounded_String("Asis.Statements.Requeue_Entry_Name")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.Delay_Expression'Access),
          To_Bounded_String("Asis.Statements.Delay_Expression")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.Guard'Access),
          To_Bounded_String("Asis.Statements.Guard")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.Choice_Parameter_Specification'Access),
          To_Bounded_String("Asis.Statements.Choice_Parameter_Specification")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.Raised_Exception'Access),
          To_Bounded_String("Asis.Statements.Raised_Exception")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.Associated_Message'Access),
          To_Bounded_String("Asis.Statements.Associated_Message")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Asis.Statements.Qualified_Expression'Access),
          To_Bounded_String("Asis.Statements.Qualified_Expression")),

         --Thick_Queries
         ((Kind => An_Element,
           Option => An_Element,
           Element => Thick_Queries.Ultimate_Enclosing_Instantiation'Access),
          To_Bounded_String("Thick_Queries.Ultimate_Enclosing_Instantiation")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Thick_Queries.Subtype_Simple_Name'Access),
          To_Bounded_String("Thick_Queries.Subtype_Simple_Name")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Thick_Queries.First_Subtype_Name'Access),
          To_Bounded_String("Thick_Queries.First_Subtype_Name")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Thick_Queries.Access_Target_Type'Access),
          To_Bounded_String("Thick_Queries.Access_Target_Type")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Thick_Queries.Corresponding_Component_Clause'Access),
          To_Bounded_String("Thick_Queries.Corresponding_Component_Clause")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Thick_Queries.Corresponding_Enumeration_Clause'Access),
          To_Bounded_String("Thick_Queries.Corresponding_Enumeration_Clause")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Thick_Queries.Simple_Name'Access),
          To_Bounded_String("Thick_Queries.Simple_Name")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Thick_Queries.Strip_Attributes'Access),
          To_Bounded_String("Thick_Queries.Strip_Attributes")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Thick_Queries.First_Defining_Name'Access),
          To_Bounded_String("Thick_Queries.First_Defining_Name")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Thick_Queries.Ultimate_Expression'Access),
          To_Bounded_String("Thick_Queries.Ultimate_Expression")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Thick_Queries.Corresponding_Expression_Type_Definition'Access),
          To_Bounded_String("Thick_Queries.Corresponding_Expression_Type_Definition")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Thick_Queries.Ultimate_Expression_Type'Access),
          To_Bounded_String("Thick_Queries.Ultimate_Expression_Type")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Thick_Queries.Called_Simple_Name'Access),
          To_Bounded_String("Thick_Queries.Called_Simple_Name")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Thick_Queries.Formal_Name'Access),
          To_Bounded_String("Thick_Queries.Formal_Name")),
         ((Kind => An_Element,
           Option => An_Element,
           Element => Thick_Queries.External_Call_Target'Access),
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

   procedure Print_Result (Result : in Asis.Element; Name : BOUNDED_STRING; Index : Integer) is
      use Asis, Asis.Elements, Asis.Text;
      use Ada.Strings, Ada.Strings.Wide_Fixed;

      procedure Display(Name : BOUNDED_STRING) is
         use Ada.Characters.Handling;
      begin
         Put(To_Wide_String(To_String(Name)));
      end;

      Res_Span : Span;

   begin
      if Element_Kind(Result) /= Not_An_Element then
         Res_Span := Element_Span(Result);
         New_Line;
         Put(--Unit_Name(1 .. Unit_Name_Length) & ":" &
             ">>> " &
               Trim(Natural'Wide_Image(Res_Span.First_Line),Both) & ":" &
               Trim(Natural'Wide_Image(Res_Span.First_Column), Both) & ": --- ");
         Display(Name);
         if Index /= 0 then
            Put("("&Trim(Integer'Wide_Image(Index), Both)&")");
         end if;
         New_Line;
         Put_Line(Trim(Element_Image(Result), Both));
      else
         Put(">>> Not_An_Element : --- ");
         Display(Name);
         New_Line;
      end if;
   end Print_Result;

   procedure Pre_Procedure (Element : in Asis.Element;
                            Control    : in out Asis.Traverse_Control;
                            State      : in out Boolean) is
      use Asis, Asis.Elements, Asis.Expressions, Asis.Text;
      use Ada.Strings, Ada.Strings.Wide_Fixed;
      use Utilities;

      Result : Asis.Element;
      Arg_Span : Span := Element_Span(Element);

   begin -- Pre_Procedure

      Put_Line(--Unit_Name(1 .. Unit_Name_Length) & ":" &
               "<<< " &
                 Trim(Natural'Wide_Image(Arg_Span.First_Line),Both) & ":" &
                 Trim(Natural'Wide_Image(Arg_Span.First_Column), Both) & ":");
      Put_Line(Trim(Element_Image(Element), Both));

      for I in Asis_Functions'Range loop
         begin
            case Asis_Functions(I).Call.Option is
               when A_Context =>
                  declare
                     Result : Asis.Context := Asis_Functions(I).Call.Context((Element));
                  begin
                     null;
                     --Print_Result(Result, Asis_Functions(I).Name, 0);
                  end;
               when An_Element =>
                  declare
                     Result : Asis.Element := Asis_Functions(I).Call.Element((Element));
                  begin
                     Print_Result(Result, Asis_Functions(I).Name, 0);
                  end;
               when An_Element_List =>
                  declare
                     Result : Asis.Element_List := Asis_Functions(I).Call.Element_List((Element));
                  begin
                     for J in Result'Range loop
                        Print_Result(Result(J), Asis_Functions(I).Name, J);
                     end loop;
                  end;
               when A_Compilation_Unit =>
                  declare
                     Result : Asis.Compilation_Unit := Asis_Functions(I).Call.Compilation_Unit((Element));
                  begin
                     null;
                     --Print_Result(Result, Asis_Functions(I).Name, 0);
                  end;
               when A_Compilation_Unit_List =>
                  declare
                     Result : Asis.Compilation_Unit_List := Asis_Functions(I).Call.Compilation_Unit_List((Element));
                  begin
                     for J in Result'Range loop
                        null;
                        --Print_Result(Result(J), Asis_Functions(I).Name, J);
                     end loop;
                  end;
            end case;
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
