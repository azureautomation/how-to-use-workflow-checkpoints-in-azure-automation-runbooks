How to use workflow checkpoints in Azure Automation Runbooks
============================================================

            

**Description**


** **This tutorial runbook demonstrates how to use workflow checkpoints in an Azure Automation runbook. Checkpointing can be useful for actions that should not be repeated if a runbook were to suspend and need to be resumed. For example,
 one usage of checkpointing would be to call 'Checkpoint-Workflow' after the creation of a VM in order to avoid creating a duplicate VM if the runbook were to suspend and were later to be resumed. 


** **


 **Requirements**




In order to run this runbook, you must first have created the following Automation Asset:


  *  Variable 'HasBeenSuspended' of type boolean  





 


**Runbook Content**




The runbook's content is displayed below: 


 

 

        
    
TechNet gallery is retiring! This script was migrated from TechNet script center to GitHub by Microsoft Azure Automation product group. All the Script Center fields like Rating, RatingCount and DownloadCount have been carried over to Github as-is for the migrated scripts only. Note : The Script Center fields will not be applicable for the new repositories created in Github & hence those fields will not show up for new Github repositories.
