// SPDX-FileCopyrightText: 2026 Niclas Andersson and contributors
// SPDX-License-Identifier: MIT
import DButton from "discourse/components/d-button";
import { apiInitializer } from "discourse/lib/api";

const ResourcesLink = <template>
  <li>
    <DButton @route="resources-example" @translatedLabel="Resources" />
  </li>
</template>;

export default apiInitializer((api) => {
  api.headerIcons.add("resources-example", ResourcesLink);
});
