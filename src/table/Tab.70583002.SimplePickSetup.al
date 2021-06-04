table 70583002 "Simple Pick Setup"
{
    DataClassification = ToBeClassified;
    Caption = 'Simple Pick Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Simple Pick"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Enable Simple Pick';

        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}