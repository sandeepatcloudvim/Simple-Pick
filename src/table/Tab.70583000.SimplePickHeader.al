table 70583000 "Simple Pick Header"
{
    //Created Simple Pick Header table
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
            OptionCaption = 'OPEN,PRINTED,COMPLETED';
            OptionMembers = OPEN,PRINTED,COMPLETED;
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
    trigger OnDelete()
    var
        SimplePickLine: Record "Simple Pick Line";
    begin
        SimplePickLine.Reset();
        SimplePickLine.SetRange("Document No.", "Document No.");
        SimplePickLine.SetRange("Version No.", "Version No.");
        if SimplePickLine.FindSet() then
            SimplePickLine.DeleteAll();
    end;
}

