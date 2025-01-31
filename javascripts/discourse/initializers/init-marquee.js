import { apiInitializer } from "discourse/lib/api";
import Marquee from "../components/marquee";

export default apiInitializer("1.8.0", (api) => {
  api.renderInOutlet("above-site-header", Marquee);
});
