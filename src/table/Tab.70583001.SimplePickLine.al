table 70583001 "Simple Pick Line"
{
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
        field(9; "Qty. Picked"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(10; "Sales Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Pick Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'OPEN,PRINTED,PICKED';
            OptionMembers = OPEN,PRINTED,PICKED;
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

