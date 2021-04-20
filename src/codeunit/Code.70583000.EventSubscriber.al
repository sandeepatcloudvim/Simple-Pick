codeunit 70583000 "Event Trigger"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', true, true)]
    local procedure ValidatePickQuanity(VAR SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; VAR HideProgressWindow: Boolean)
    var
        SimplePickHeader: Record "Simple Pick Header";
    begin
        SimplePickHeader.RESET;
        SimplePickHeader.SETRANGE("Sales Order No.", SalesHeader."No.");
        SimplePickHeader.SETFILTER("Pick Status", '%1', SimplePickHeader."Pick Status"::PICKED);
        IF NOT SimplePickHeader.FINDSET THEN
            ERROR('Quantity not yet completely picked');
    end;
}