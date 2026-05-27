# Shows current Azure subscription and logged-in account
az account show --query "{Subscription:name, SubscriptionId:id, TenantId:tenantId, User:user.name}" -o table
