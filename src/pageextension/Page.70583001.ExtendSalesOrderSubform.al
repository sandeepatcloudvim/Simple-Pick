pageextension 70583001 Extend_SalesOrderSubform extends "Sales Order Subform"
{
    //Added the "Qty. Picked" field.
    layout
    {
        addbefore("Qty. to Ship")
        {
            field("Qty. to Pick"; Rec."Qty. to Pick")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = SimplePickEnable;
            }
            field("Qty. Picked"; Rec."Qty. Picked")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = SimplePickEnable;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        SimplePickEnable: Boolean;
        SimplePickSetup: Record "Simple Pick Setup";

    trigger OnOpenPage()
    var
    begin
        if SimplePickSetup.Get() then;
        if SimplePickSetup."Simple Pick" then
            SimplePickEnable := true;
    end;

}