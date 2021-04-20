tableextension 70583000 Extend_SalesLine_37 extends "Sales Line"
{
    fields
    {
        field(50000; "Qty. Picked"; Decimal)
        {
            CalcFormula = Sum("Simple Pick Line"."Qty. Picked" WHERE("Sales Order No" = FIELD("Document No."),
                                                                      "Sales Line No." = FIELD("Line No.")));
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
        }
    }

    var
        myInt: Integer;
}