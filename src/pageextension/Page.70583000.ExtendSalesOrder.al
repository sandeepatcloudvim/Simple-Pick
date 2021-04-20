pageextension 70583000 Extend_SalesOrder_42 extends "Sales Order"
{
    layout
    {
        addafter(Control1906127307)
        {
            part(Control100000567; "Simple Pick Factbox")
            {
                SubPageLink = "Sales Order No." = FIELD("No.");
                SubPageView = SORTING("Document No.", "Version No.")
                              ORDER(Ascending);
            }
        }
    }

    actions
    {
        addafter(Customer)
        {
            action("Simple Pick")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Simple Pick';
                Image = PickLines;
                Promoted = true;
                PromotedCategory = Category12;

                trigger OnAction()
                begin
                    InsertSimplePick(Rec);
                    SimplePickHeader.Reset;
                    SimplePickHeader.SetRange("Sales Order No.", Rec."No.");
                    if SimplePickHeader.FindLast then
                        PAGE.Run(PAGE::"Simple Pick", SimplePickHeader);
                end;
            }
        }
    }

    var
        myInt: Integer;
        SimplePickHeader: Record "Simple Pick Header";
        SimplePickLine: Record "Simple Pick Line";
        LoopCount: Integer;

    local procedure InsertSimplePick(recSalesHeader: Record "Sales Header")
    var
        recSalesLine: Record "Sales Line";
    begin
        LoopCount := 0;
        recSalesLine.Reset;
        recSalesLine.SetRange("Document Type", recSalesLine."Document Type"::Order);
        recSalesLine.SetRange("Document No.", recSalesHeader."No.");
        if recSalesLine.FindSet then begin
            repeat
                if not DuplicateItemQty(recSalesLine."Document No.", recSalesLine."Line No.", recSalesLine.Quantity) then begin
                    if LoopCount = 0 then
                        CreateSimplePickHeader(recSalesLine);
                    CreateSimplePickLine(recSalesLine);
                    LoopCount := LoopCount + 1;
                end;
            until recSalesLine.Next = 0;
        end;
    end;

    local procedure CheckSimplePickLine(OrderNo: Code[20]): Integer
    var
        SimplePickHeader1: Record "Simple Pick Header";
    begin
        SimplePickHeader1.Reset;
        SimplePickHeader1.SetRange("Sales Order No.", OrderNo);
        if SimplePickHeader1.FindLast then
            exit(SimplePickHeader1."Version No." + 1)
        else
            exit(1);
    end;

    local procedure GetLastLineNo(DocumentNo: Code[20]): Integer
    var
        recSimplePickLine1: Record "Simple Pick Line";
    begin
        recSimplePickLine1.Reset;
        recSimplePickLine1.SetRange("Document No.", DocumentNo);
        if recSimplePickLine1.FindLast then
            exit(recSimplePickLine1."Line No." + 10000)
        else
            exit(10000);
    end;

    local procedure DuplicateItemQty(DocNo: Code[20]; LineNo: Integer; Qty: Decimal): Boolean
    var
        PickLines: Record "Simple Pick Line";
    begin
        PickLines.Reset;
        PickLines.SetRange("Sales Order No", DocNo);
        PickLines.SetRange("Sales Line No.", LineNo);
        PickLines.SetRange("Line Quantity", Qty);
        if PickLines.FindFirst then
            exit(true)
        else
            exit(false);
    end;

    local procedure CreateSimplePickHeader(SalesLine: Record "Sales Line")
    begin
        SimplePickHeader.Init;
        SimplePickHeader."Document No." := SalesLine."Document No." + '-' + Format(CheckSimplePickLine(SalesLine."Document No."));
        SimplePickHeader."Version No." := CheckSimplePickLine(SalesLine."Document No.");
        SimplePickHeader."Sales Order No." := SalesLine."Document No.";
        SimplePickHeader."Pick Creation Date" := WorkDate;
        SimplePickHeader.Insert(true);
    end;

    local procedure CreateSimplePickLine(SalesLine1: Record "Sales Line")
    begin
        SimplePickLine.Init;
        SimplePickLine."Document No." := SimplePickHeader."Document No.";
        SimplePickLine."Version No." := SimplePickHeader."Version No.";
        SimplePickLine."Line No." := GetLastLineNo(SimplePickHeader."Document No.");
        SimplePickLine."Sales Order No" := SimplePickHeader."Sales Order No.";
        SimplePickLine."Sales Line No." := SalesLine1."Line No.";
        SimplePickLine."Item No." := SalesLine1."No.";
        SimplePickLine.Description := SalesLine1.Description;
        SimplePickLine."Line Quantity" := SalesLine1.Quantity;
        SimplePickLine."Qty. to Pick" := SalesLine1.Quantity - Abs(GetPickLineQty(SalesLine1."Document No.", SalesLine1."Line No."));
        SimplePickLine.Insert(true);
    end;

    local procedure GetPickLineQty(DocNo1: Code[20]; LineNo1: Integer): Decimal
    var
        PickLines1: Record "Simple Pick Line";
    begin
        PickLines1.RESET;
        PickLines1.SETRANGE("Sales Order No", DocNo1);
        PickLines1.SETRANGE("Sales Line No.", LineNo1);
        PickLines1.CALCSUMS("Qty. to Pick");
        EXIT(PickLines1."Qty. to Pick")
    end;
}