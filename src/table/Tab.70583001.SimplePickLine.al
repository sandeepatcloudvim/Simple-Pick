table 70583001 "Simple Pick Line"
{
    //Created Simple Pick Line table
    Caption = 'Simple Pick Line';
    DataCaptionFields = "Document No.", "Version No.";
    DrillDownPageID = "Simple Pick Lines";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Version No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Sales Order No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Description; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Line Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Qty. to Pick"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;

        }
        field(9; "Sales Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Pick Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'OPEN,PRINTED,PICKED';
            OptionMembers = OPEN,PRINTED,PICKED;
        }
        field(11; "Qty. Picked"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            trigger Onvalidate()
            var
                recSalesLine: Record "Sales Line";
                recSimplePickLine: Record "Simple Pick Line";
                recSimplePickHeader: Record "Simple Pick Header";
            begin
                if ("Qty. Picked" > "Qty. to Pick") then begin
                    Error('Qty. Picked can not be greater than the Qty. to picked')
                end;
                if recSimplePickHeader.get(Rec."Document No.", Rec."Version No.") then begin
                    if (recSimplePickHeader."Pick Status" = recSimplePickHeader."Pick Status"::COMPLETED) then begin
                        Error('Pick Status is COMPLETED so you can not modify Qty. To Pick value')
                    end;
                end;
            end;

        }

    }

    keys
    {
        key(Key1; "Document No.", "Version No.", "Line No.")
        {
            Clustered = true;
        }
    }


    fieldgroups
    {
    }

}

