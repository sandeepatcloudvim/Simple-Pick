page 70583001 "Simple Pick"
{
    PageType = ListPlus;
    SourceTable = "Simple Pick Header";
    Editable = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Pick Creation Date"; Rec."Pick Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                }
                field("Version No."; Rec."Version No.")
                {
                    ApplicationArea = All;
                }
                field("Pick Status"; Rec."Pick Status")
                {
                    ApplicationArea = All;
                }
            }
            part(Control100000009; "Simple Pick Lines")
            {
                SubPageLink = "Document No." = FIELD("Document No."),
                              "Version No." = FIELD("Version No.");
                SubPageView = SORTING("Document No.")
                              ORDER(Ascending);
            }
        }
        area(factboxes)
        {
            systempart(Control100000007; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control100000006; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action(SimplePickReport)
            {
                Caption = 'Simple Pick';
                Image = Report;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    SimplePick: Record "Simple Pick Header";
                begin
                    SimplePick := Rec;
                    SimplePick.SetRecFilter;
                    REPORT.RunModal(REPORT::"Simple Pick Report", true, false, SimplePick);
                end;
            }
        }
    }
}

