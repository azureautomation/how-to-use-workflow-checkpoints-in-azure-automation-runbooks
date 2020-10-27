<#
.SYNOPSIS 
    Demonstrates the use of PowerShell workflow checkpoints in a runbook.

.DESCRIPTION
   Checkpointing can be useful for actions that should not be repeated if a 
   runbook were to suspend and need to be resumed. For example, one usage of 
   checkpointing would be to call 'Checkpoint-Workflow' after the creation of
   a VM in order to avoid creating a duplicate VM if the runbook were to 
   suspend and were later to be resumed.

   A runbook can be suspended for a number of reasons. Suspends happen mostly due
   to errors. For example, an uncaught exception in a runbook, a network failure,
   or a crash on the Runbook Worker running the runbook, will all cause the runbook
   to be suspended and start from its last checkpoint when resumed. The user can also manually
   request a runbook to suspend, which will cause it to suspend at its next checkpoint. 
   Windows Azure Automation also uses a "Fair Share" model to make sure all tenants' runbook
   jobs get a chance to execute on a Runbook Worker. This means that, if a runbook executes
   for more than 30 minutes, it will be automatically suspended at its last checkpoint to
   give other tenants' runbook jobs a chance to run. After each other tenant has received
   their 30 minute run period for their jobs, this runbook job will be resumed from its last
   checkpoint and allowed to continue to run for another 30 minute period. Because runbooks
   can be suspended for various reasons, runbook authors should always assume their runbooks
   may be suspended, and implement their runbooks with checkpoints accordingly.

   When this runbook initially starts, it creates a checkpoint. After the 
   checkpoint, if 'HasBeenSuspended' is false and the runbook has not yet been suspended, 
   the runbook enters a portion of code with an error in it that throws an exception 
   causing it to suspend. 

   When the runbook is manually resumed by the user later, it resumes
   from the checkpoint. When the runbook checks if it has previously suspended,
   'HasBeenSuspended' will be true, so the runbook will successfully complete.

   Before running this workflow, you must create an SMA Boolean variable asset named 
   'HasBeenSuspended'.


.NOTES
    AUTHOR: System Center Automation Team
    LASTEDIT: Jan 31, 2014    
#>

workflow Use-WorkflowCheckpointSample
{
	# An exception occurs if 'HasBeenSuspended' does not already exist.
	# Exceptions that are not caught with a try/catch will cause the runbook to suspend.
    Set-AutomationVariable -Name 'HasBeenSuspended' -Value $False

    # This line occurs before the checkpoint. When the runbook is resumed after
    # suspension, 'Before Checkpoint' will not be output a second time.
    Write-Output "Before Checkpoint"
    
    # A checkpoint is created.
    Checkpoint-Workflow

    # This line occurs after the checkpoint. The runbook will start here on resume.
    Write-Output "After Checkpoint"
    
    $HasBeenSuspended = Get-AutomationVariable -Name 'HasBeenSuspended'
    
    # If branch only executes if the runbook has not previously suspended.
    if (!$HasBeenSuspended) {
        Set-AutomationVariable -Name 'HasBeenSuspended' -Value $True

        # This will cause a runtime exception. Any runtime exception in a runbook
		# will cause the runbook to suspend.
        1 + "abc"
    }
    
    Write-Output "Runbook Complete"
}