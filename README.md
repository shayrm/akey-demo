# akey-demo
Demo with Akeyless technology and DFC (Disterbuted Fragment Cryptogrphy) 

## Theory 

Answering some theoretical questions before demo description.

### UI management and features

1. What are Authentication Methods?
   
3. What are Access Roles?
   * Akeyless Role-based Access Control (RBAC) follows the **least privilege** principle to limit access rights for machines/human users 
     to the bare minimum of permissions they need to perform their work.
   * Access Roles can be configured to grant permissions on Secrets & Encryption Keys, Targets, Authentication methods and Access Roles, 
     you can also control user access to audit logs, analytics, Gateways settings and Secure Remote Access (SRA) information.

To set permission for a user to work with any item in the Platform, an appropriate Access Role must be assigned to the Authentication Method that represents this user. By default, users don't have any permissions in Akeyless unless explicitly granted.

We associate specific clients with a certain Authentication Method to an Access Role to increase operational flexibility. The user can define any number of roles with permissions per each role.


4. What kind of Secrets can be created?
