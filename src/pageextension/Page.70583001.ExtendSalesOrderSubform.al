pageextension 70583001 Extend_SalesOrderSubform extends "Sales Order Subform"
{
    layout
    {
        addbefore("Qty. to Ship")
        {
            field("Qty. Picked"; Rec."Qty. Picked")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}