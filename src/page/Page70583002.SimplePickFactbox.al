page 70583002 "Simple Pick Factbox"
{
    PageType = CardPart;
    SourceTable = "Simple Pick Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        PAGE.Run(PAGE::"Simple Pick", Rec);
                    end;
                }
                field("Version No."; Rec."Version No.")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
    }

    var
        recPickHeader: Record "Simple Pick Header";
}