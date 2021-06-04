page 70583000 "Simple Pick Lines"
{
    //Simple Pick Lines page
    PageType = ListPart;
    SourceTable = "Simple Pick Line";
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Qty to Pick"; Rec."Qty. to Pick")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Qty. Picked"; Rec."Qty. Picked")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
            }
        }
    }

    actions
    {
    }
    var
        varQtyPicked: Decimal;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        recSalesLine: Record "Sales Line";
        recSimplePickLine: Record "Simple Pick Line";
        recSimplePickHeader: Record "Simple Pick Header";
        varQtyPicked: Decimal;

    begin
        if recSimplePickHeader.get(Rec."Document No.", Rec."Version No.") then begin
            if (recSimplePickHeader."Pick Status" = recSimplePickHeader."Pick Status"::COMPLETED) then begin
                recSalesLine.Reset();
                recSalesLine.SetRange("Document Type", recSalesLine."Document Type"::Order);
                recSalesLine.SetRange("Document No.", Rec."Sales Order No");
                if recSalesLine.FindSet() then
                    repeat
                        recSalesLine.Validate("Qty. to Ship", UpdatePickedQty(recSalesLine) - recSalesLine."Quantity Shipped");
                        recSalesLine.Modify(false);
                    until recSalesLine.Next() = 0;
            end;
        end;
    end;

    local procedure UpdatePickedQty(SalesLine: Record "Sales Line"): Decimal
    var
        myInt: Integer;
        recSimplePickLine: Record "Simple Pick Line";
    begin
        varQtyPicked := 0;
        recSimplePickLine.Reset();
        recSimplePickLine.SetRange("Sales Order No", SalesLine."Document No.");
        recSimplePickLine.SetRange("Sales Line No.", SalesLine."Line No.");
        if recSimplePickLine.FindSet() then
            repeat
                varQtyPicked := varQtyPicked + recSimplePickLine."Qty. Picked";
            until recSimplePickLine.Next() = 0;
        exit(varQtyPicked);
    end;

}

