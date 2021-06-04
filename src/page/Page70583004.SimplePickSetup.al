page 70583004 "Simple Pick Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Simple Pick Setup";

    layout
    {
        area(Content)
        {
            group("Simple Pick Setup")
            {
                field(Simple_Pick; Rec."Simple Pick")
                {
                    ApplicationArea = All;
                    Caption = 'Enable Simple Pick';

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;

    trigger OnOpenPage()
    var
    begin
        rec.RESET;
        IF NOT rec.GET THEN BEGIN
            rec.INIT;
            rec.INSERT;
        END;
    end;
}