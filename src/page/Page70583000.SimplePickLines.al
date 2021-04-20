page 70583000 "Simple Pick Lines"
{
    PageType = List;
    SourceTable = "Simple Pick Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Qty to Pick"; Rec."Qty. to Pick")
                {
                    ApplicationArea = All;
                }
                field("Qty. Picked"; Rec."Qty. Picked")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

