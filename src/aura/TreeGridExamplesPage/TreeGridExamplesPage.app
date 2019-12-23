<!--
 - Created by Jesse Glover on 12/23/19.
 -->

<!-- The actual web page that will be displayed on screen.
extends is designed to complement the user experience with continuous productivity feature releases
force:slds allows for application definition to implement the SLDS style sheets and design tokens from Lightning Design System -->
<aura:application description="TreeGridExamplesPage" extends="force:slds">
    <!-- the c: syntax allow a developer to tie a component or multiple components to a single page -->
    <!--<c:TreeGridExamplesComponent/>-->
    <c:TreeGridNestedDataComponent />
</aura:application>