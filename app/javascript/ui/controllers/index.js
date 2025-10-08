import { application } from "ui/controllers/application";
import { eagerLoadEngineControllersFrom } from "ui/controllers/loader";

// Load component controllers
eagerLoadEngineControllersFrom("ui/components", application);
