/**
 * Created by gamedevmadeeasy on 1/23/20.
 */

public class LinkedInParser {
    public String Id {get; set;}
    public cls_firstName firstName {get; set;}
    public cls_lastName lastName {get; set;}
    public cls_profilePicture profilePicture {get; set;}

    public class cls_firstName {
        public cls_localized localized {get; set;}
        public cls_preferredLocale preferredLocale {get; set;}
    }

    public class cls_localized {
        public String en_US {get; set;}   //Glover
    }

    public class cls_preferredLocale {
        public String country {get; set;}    //US
        public String language {get; set;}   //en
    }

    public class cls_lastName {
        public cls_localized localized {get; set;}
        public cls_preferredLocale preferredLocale {get; set;}
    }

    public class cls_profilePicture {
        public String displayImage {get; set;}
    }
}