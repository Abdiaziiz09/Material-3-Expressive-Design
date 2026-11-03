# Expressive screen recipes

These recipes demonstrate common screens that are often needed by apps built on Material 3 Expressive-informed principles. The examples define implementation structure, not official Material token values. Where a behavior is not explicitly defined by the source, treat it as an implementation recommendation and validate it against the target device, platform, and accessibility requirements.

## Onboarding flow

Use a sequential introduction with a strong visual hierarchy, a single primary action, and short content blocks. Keep the call-to-action clear and avoid visually competing controls.

**Recommended structure**

- Hero heading and supporting text
- Optional illustrative graphic or product image
- Short list of value statements with icons
- Primary action: continue / get started
- Secondary action: sign in / skip

**Flutter mapping**

- `PageView` or a single-screen stepper, depending on product needs
- `FilledButton` for the main action
- `TextButton` or `OutlinedButton` for a secondary action
- `Card` or custom layout container for summary blocks

**Validation**

- Keyboard focus order is logical and non-duplicated
- Large text and localization do not break the layout
- Error or empty states are handled on the sign-up path
- Buttons remain distinguishable at reduced motion and high-contrast settings

## Profile / personal details

Profile screens should prioritize identity and action hierarchy: name, role, metadata, and short supporting information. Keep actions limited to the most common tasks and place secondary actions in a context menu or settings flow if needed.

**Recommended structure**

- Header with avatar, name, status, and identity labels
- Summary chips or tags
- Key metadata rows
- Primary action row for follow, contact, or edit
- Secondary actions when needed, such as manage account or share

**Flutter mapping**

- `CircleAvatar` or image container for the profile picture
- `ChoiceChip` or `FilterChip` for tags or roles
- `ListTile` for metadata rows
- `FilledButton.tonal` or `FilledButton` for the main action

**Validation**

- Check avatar fallback and text scaling
- Ensure chips remain readable in dark mode
- Preserve proper semantics for each row and action
- Test editing and follow flows on smaller and larger widths

## Search and discovery

Search patterns need a clear relationship between query, suggestions, and results. The interface should communicate what is being filtered, what is loading, and what happens when there are no results.

**Recommended structure**

- Search input with clear placeholder text
- Filter chips or segmented controls for category narrowing
- Result list with title, metadata, and optional leading icon
- Empty, loading, and error states
- Optional suggestions or recent searches

**Flutter mapping**

- `SearchBar` or `TextField` inside a `Material` container
- `FilterChip` or `SegmentedButton` for property filtering
- `ListView` and `ListTile` for results
- `SnackBar` or inline message for transient status updates

**Validation**

- Keyboard interaction supports focus, text entry, and arrow navigation
- Loading state is visible and not replaced by a blank container
- Empty results show a clear recovery path
- Filter chips remain accessible when the user changes locale or text scale

## Feed / community / content stream

Feeds should reduce friction for scanning, prioritization, and active reading. Use repeated cards or list rows with a clear hierarchy and avoid decorating each item equally when the content demands emphasis.

**Recommended structure**

- Header or section title above a list or masonry-like card stream
- Row or card-based content blocks with title, summary, metadata, and action row
- Secondary controls for reactions, saves, shares, or comments
- Data/empty/loading states for new content

**Flutter mapping**

- `Card` or custom container with `ListTile`-like structure
- `InkWell` for tap interactions when appropriate
- `FilledButton` or `TextButton` for primary and secondary actions
- `Wrap` or chips for categories

**Validation**

- Ensure action labels and text remain readable as density changes
- Check list item semantics and focus order
- Confirm screen-reader users can identify primary content vs secondary action
- Validate long content and both light/dark theme combinations

## Messaging and chat

Chat interfaces require careful treatment of content groups, timestamps, and focus. The design should support a thread or list of messages with a clear active composer and visible status information.

**Recommended structure**

- Conversation list or channel list for context
- Active thread with incoming/outgoing message grouping
- Composer field with send action
- Optional attachment or action button related to the message task

**Flutter mapping**

- `ListView` for conversation history
- `TextField` or `SearchBar` for the composer
- `Card` or custom bubble-style container for message content
- `FloatingActionButton` or secondary action for send or new conversation

**Validation**

- Ensure high volume text does not overlap timestamps or message edges
- Test keyboard input, IME handling, and message send actions
- Verify accessible names for actions and message content
- Check for safe areas and system insets on Android and iOS phones and tablets

## Notifications and activity

Notifications should separate critical, actionable, and informational items. Create a clear distinction between ephemeral feedback and persistent status.

**Recommended structure**

- Section header for today / recent / unread
- List rows with a status dot or badge
- Clear action affordances when the item is actionable
- Persistent fallback for critical updates where needed

**Flutter mapping**

- `ListView` with `ListTile`
- `Badge` or custom status chip where appropriate
- `SnackBar` for transient notifications
- `AlertDialog` for critical confirmation when a user action is required

**Validation**

- Distinguish transient and persistent status clearly
- Verify screen-reader announcements for new notifications
- Ensure action availability is not hidden behind an unclear icon alone
- Validate large text and RTL layout adaptation

## Settings and account management

Settings screens benefit from clear grouping, explicit labels, and strong separation between general preferences and destructive or irreversible actions.

**Recommended structure**

- Sectioned categories (account, appearance, notifications, privacy)
- `SwitchListTile` or `CheckboxListTile` for preferences
- `ListTile` for route-based actions
- Action sheet or dialog for dangerous operations

**Flutter mapping**

- `ListView` with grouped rows
- `SwitchListTile`, `CheckboxListTile`, and `RadioListTile`
- `Dialog` or `AlertDialog` for confirmation flows
- `FilledButton.icon` for save or apply actions

**Validation**

- Test all controls under text scaling and localization
- Ensure destructive actions are unmistakably stated and confirmed
- Preserve a coherent focus path across grouped settings
- Confirm both light and dark themes have sufficient contrast

## Implementation notes for AI agents

When implementing a screen recipe:

- start from the app's semantic goal, not a guessed visual style
- prefer theme-driven color and shape values over hard-coded values
- verify supported Flutter APIs against the chosen SDK and platform
- document each custom implementation choice and the source gap it addresses
- validate touch, any supported external input, localization, and accessibility behavior before claiming fidelity

This file adds practical, app-oriented guidance. It is intended to complement the [component coverage matrix](../reference/component-coverage.md), [support matrix](../reference/support-matrix.md), and the [validation checklist](../ai-agent-guide/validation-checklist.md).
