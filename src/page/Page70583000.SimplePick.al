page 70583001 "Simple Pick"
{
    //Simple Pick Header page
    PageType = Document;
    SourceTable = "Simple Pick Header";
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Pick Creation Date"; Rec."Pick Creation Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Version No."; Rec."Version No.")
                {
                    ApplicationArea = All;
                    Editable = false;
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

