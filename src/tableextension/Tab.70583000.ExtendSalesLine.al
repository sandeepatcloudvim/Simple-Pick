tableextension 70583000 Extend_SalesLine_37 extends "Sales Line"
{
    //Added the "Qty. Picked" field.
    fields
    {
        field(50000; "Qty. Picked"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Simple Pick Line"."Qty. Picked" where("Sales Order No" = field("Document No."), "Sales Line No." = field("Line No.")));
            DecimalPlaces = 0 : 5;

        }
        field(50001; "Qty. to Pick"; Decimal)
        {
            CalcFormula = Sum("Simple Pick Line"."Qty. to Pick" where("Sales Order No" = field("Document No."), "Sales Line No." = field("Line No.")));
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
        }
    }

    var
        myInt: Integer;

    trigger OnBeforeDelete()
    var
        SimplePickSetup1: Record "Simple Pick Setup";
        recSimplePickHeader: Record "Simple Pick Header";
        recSimpleLine: Record "Simple Pick Line";
    begin
        if SimplePickSetup1.Get() then;
        if not SimplePickSetup1."Simple Pick" then
            exit;

        CalcFields("Qty. to Pick");
        if ("Qty. to Pick" > 0) AND (SimplePickStatus("Document No.")) then begin
            Error('Item %1 line contanis Qty. to Pick value so it will not allow you to delete lines', "No.");
        end else begin
            recSimpleLine.Reset();
            recSimpleLine.SetRange("Sales Order No", "Document No.");
            recSimpleLine.SetRange("Sales Line No.", "Line No.");
            if recSimpleLine.FindFirst() then
                recSimpleLine.Delete();
        end;
    end;

    local procedure SimplePickStatus(DocumentNo: Code[20]): Boolean
    var
        recSimplePickHeader: Record "Simple Pick Header";
    begin
        recSimplePickHeader.Reset();
        recSimplePickHeader.SetRange("Sales Order No.", DocumentNo);
        recSimplePickHeader.SetFilter("Pick Status", '<> %1', recSimplePickHeader."Pick Status"::COMPLETED);
        if recSimplePickHeader.FindSet() then
            exit(true);
    end;

}