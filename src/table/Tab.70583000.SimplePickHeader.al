table 70583000 "Simple Pick Header"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Pick Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Version No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Pick Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'OPEN,PRINTED,PICKED';
            OptionMembers = OPEN,PRINTED,PICKED;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Version No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

