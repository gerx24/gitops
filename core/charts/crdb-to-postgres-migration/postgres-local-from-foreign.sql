CREATE TABLE client_side.local_actives (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    mount_id uuid NOT NULL,
    release_id uuid NOT NULL
);

INSERT INTO client_side.local_actives (id, inserted_at, updated_at, mount_id, release_id)
SELECT id, inserted_at, updated_at, mount_id, release_id
FROM client_side.actives;

DROP FOREIGN TABLE IF EXISTS client_side.actives;

ALTER TABLE client_side.local_actives RENAME TO actives;

--
-- Name: mounts; Type: TABLE; Schema: client_side; Owner: -
--

CREATE TABLE client_side.local_mounts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying(255) NOT NULL,
    paused boolean DEFAULT false NOT NULL
);

INSERT INTO client_side.local_mounts (id, inserted_at, updated_at, name, paused)
SELECT id, inserted_at, updated_at, name, paused
FROM client_side.mounts;

DROP FOREIGN TABLE IF EXISTS client_side.mounts;

ALTER TABLE client_side.local_mounts RENAME TO mounts;

--
-- Name: releases; Type: TABLE; Schema: client_side; Owner: -
--

CREATE TABLE client_side.local_releases (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    mount_id uuid NOT NULL,
    version character varying(255) NOT NULL,
    data jsonb DEFAULT '{}'::jsonb
);

INSERT INTO client_side.local_releases (id, inserted_at, mount_id, version, data)
SELECT id, inserted_at, mount_id, version, data
FROM client_side.releases;

DROP FOREIGN TABLE IF EXISTS client_side.releases;

ALTER TABLE client_side.local_releases RENAME TO releases;

--
-- Name: api_keys; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_api_keys (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    revoked_at timestamp without time zone,
    name character varying(255) NOT NULL,
    token bytea NOT NULL
);

INSERT INTO public.local_api_keys (id, inserted_at, revoked_at, name, token)
SELECT id, inserted_at, revoked_at, name, token
FROM public.api_keys;

DROP FOREIGN TABLE IF EXISTS public.api_keys;

ALTER TABLE public.local_api_keys RENAME TO api_keys;
--
-- Name: api_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_api_permissions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    revoked_at timestamp without time zone,
    api_key_id uuid NOT NULL,
    tenant_id uuid NOT NULL
);

INSERT INTO public.local_api_permissions (id, inserted_at, revoked_at, api_key_id, tenant_id)
SELECT id, inserted_at, revoked_at, api_key_id, tenant_id
FROM public.api_permissions;

DROP FOREIGN TABLE IF EXISTS public.api_permissions;

ALTER TABLE public.local_api_permissions RENAME TO api_permissions;

--
-- Name: brands; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_brands (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying(255),
    code character varying(255) NOT NULL,
    number integer NOT NULL,
    display_name text DEFAULT ''::text NOT NULL
);

INSERT INTO public.local_brands (id, inserted_at, updated_at, name, code, number, display_name)
SELECT id, inserted_at, updated_at, name, code, number, display_name
FROM public.brands;

DROP FOREIGN TABLE IF EXISTS public.brands;

ALTER TABLE public.local_brands RENAME TO brands;

--
-- Name: collection_pages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_collection_pages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    brand_id uuid NOT NULL,
    tenant_id uuid,
    collection_id uuid NOT NULL,
    handle character varying(255) NOT NULL,
    page_title character varying(255) NOT NULL,
    description text,
    drupal_cms_path character varying(255),
    imported_cms_data jsonb DEFAULT '{}'::jsonb,
    cache_product_data boolean DEFAULT false,
    locale character varying(255) NOT NULL,
    status character varying(255)
);

INSERT INTO public.local_collection_pages (
    id, inserted_at, updated_at, brand_id, tenant_id, collection_id, handle,
    page_title, description, drupal_cms_path, imported_cms_data,
    cache_product_data, locale, status
)
SELECT
    id, inserted_at, updated_at, brand_id, tenant_id, collection_id, handle,
    page_title, description, drupal_cms_path, imported_cms_data,
    cache_product_data, locale, status
FROM public.collection_pages;

DROP FOREIGN TABLE IF EXISTS public.collection_pages;

ALTER TABLE public.local_collection_pages RENAME TO collection_pages;
--
-- Name: collections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_collections (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying(255) NOT NULL,
    lookup_criteria jsonb
);

INSERT INTO public.local_collections (id, inserted_at, updated_at, name, lookup_criteria)
SELECT id, inserted_at, updated_at, name, lookup_criteria
FROM public.collections;

DROP FOREIGN TABLE IF EXISTS public.collections;

ALTER TABLE public.local_collections RENAME TO collections;
--
-- Name: content_partials; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_content_partials (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    cms_source character varying(255),
    cms_source_id character varying(255),
    component character varying(255),
    mapped_data jsonb,
    tenant_id uuid,
    locale character varying(255) DEFAULT 'en_US'::character varying,
    gerx24_component character varying(255),
    cms_component character varying(255),
    content jsonb
);

INSERT INTO public.local_content_partials (
    id, inserted_at, updated_at, cms_source, cms_source_id, component,
    mapped_data, tenant_id, locale, gerx24_component, cms_component, content
)
SELECT
    id, inserted_at, updated_at, cms_source, cms_source_id, component,
    mapped_data, tenant_id, locale, gerx24_component, cms_component, content
FROM public.content_partials;

DROP FOREIGN TABLE IF EXISTS public.content_partials;

ALTER TABLE public.local_content_partials RENAME TO content_partials;

--
-- Name: data_centers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_data_centers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying(255) NOT NULL,
    code character varying(255) NOT NULL,
    type character varying(255) NOT NULL
);

INSERT INTO public.local_data_centers (id, inserted_at, updated_at, name, code, type)
SELECT id, inserted_at, updated_at, name, code, type
FROM public.data_centers;

DROP FOREIGN TABLE IF EXISTS public.data_centers;

ALTER TABLE public.local_data_centers RENAME TO data_centers;

--
-- Name: fun_with_flags_toggles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_fun_with_flags_toggles (
    flag_name character varying(255) NOT NULL,
    gate_type character varying(255) NOT NULL,
    target character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);

INSERT INTO public.local_fun_with_flags_toggles (flag_name, gate_type, target, enabled, id)
SELECT flag_name, gate_type, target, enabled, id
FROM public.fun_with_flags_toggles;

DROP FOREIGN TABLE IF EXISTS public.fun_with_flags_toggles;

ALTER TABLE public.local_fun_with_flags_toggles RENAME TO fun_with_flags_toggles;
--
-- Name: global_content_cms_source_references; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_global_content_cms_source_references (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid,
    locale character varying(255) NOT NULL,
    cms_source_ids character varying(255)[] DEFAULT ARRAY[]::character varying[]
);

INSERT INTO public.local_global_content_cms_source_references (id, inserted_at, updated_at, tenant_id, locale, cms_source_ids)
SELECT id, inserted_at, updated_at, tenant_id, locale, cms_source_ids
FROM public.global_content_cms_source_references;

DROP FOREIGN TABLE IF EXISTS public.global_content_cms_source_references;

ALTER TABLE public.local_global_content_cms_source_references RENAME TO global_content_cms_source_references;
--
-- Name: global_contents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_global_contents (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    locale character varying(255),
    content jsonb
);

INSERT INTO public.local_global_contents (id, inserted_at, updated_at, tenant_id, locale, content)
SELECT id, inserted_at, updated_at, tenant_id, locale, content
FROM public.global_contents;

DROP FOREIGN TABLE IF EXISTS public.global_contents;

ALTER TABLE public.local_global_contents RENAME TO global_contents;
--
-- Name: languages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_languages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying(255) NOT NULL,
    code character varying(255) NOT NULL,
    script character varying(255),
    direction public.script_direction DEFAULT 'left_to_right'::public.script_direction NOT NULL
);

INSERT INTO public.local_languages (id, inserted_at, updated_at, name, code, script, direction)
SELECT id, inserted_at, updated_at, name, code, script, direction
FROM public.languages;

DROP FOREIGN TABLE IF EXISTS public.languages;

ALTER TABLE public.local_languages RENAME TO languages;
--
-- Name: locale_languages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_locale_languages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    locale_id uuid,
    language_id uuid,
    is_default boolean DEFAULT false,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

INSERT INTO public.local_locale_languages (id, locale_id, language_id, is_default, inserted_at, updated_at)
SELECT id, locale_id, language_id, is_default, inserted_at, updated_at
FROM public.locale_languages;

DROP FOREIGN TABLE IF EXISTS public.locale_languages;

ALTER TABLE public.local_locale_languages RENAME TO locale_languages;
--
-- Name: locales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_locales (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    region_id uuid,
    name character varying(255) NOT NULL,
    code character varying(255) NOT NULL,
    number integer NOT NULL,
    currency character varying(255) NOT NULL,
    supported_languages character varying(255)[]
);

INSERT INTO public.local_locales (id, inserted_at, updated_at, region_id, name, code, number, currency, supported_languages)
SELECT id, inserted_at, updated_at, region_id, name, code, number, currency, supported_languages
FROM public.locales;

DROP FOREIGN TABLE IF EXISTS public.locales;

ALTER TABLE public.local_locales RENAME TO locales;

--
-- Name: offer_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_offer_versions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    starts_at timestamp without time zone NOT NULL,
    ends_at timestamp without time zone,
    offer_id uuid NOT NULL,
    version bigint DEFAULT 1 NOT NULL,
    details jsonb DEFAULT '{}'::jsonb
);

INSERT INTO public.local_offer_versions (id, inserted_at, starts_at, ends_at, offer_id, version, details)
SELECT id, inserted_at, starts_at, ends_at, offer_id, version, details
FROM public.offer_versions;

DROP FOREIGN TABLE IF EXISTS public.offer_versions;

ALTER TABLE public.local_offer_versions RENAME TO offer_versions;

--
-- Name: offers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_offers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    code text NOT NULL,
    active_version_id uuid
);

INSERT INTO public.local_offers (id, inserted_at, tenant_id, code, active_version_id)
SELECT id, inserted_at, tenant_id, code, active_version_id
FROM public.offers;

DROP FOREIGN TABLE IF EXISTS public.offers;

ALTER TABLE public.local_offers RENAME TO offers;

--
-- Name: page_cms_source_references; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_page_cms_source_references (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid,
    page_id uuid,
    cms_source_ids character varying(255)[] DEFAULT ARRAY[]::character varying[]
);

INSERT INTO public.local_page_cms_source_references (id, inserted_at, updated_at, tenant_id, page_id, cms_source_ids)
SELECT id, inserted_at, updated_at, tenant_id, page_id, cms_source_ids
FROM public.page_cms_source_references;

DROP FOREIGN TABLE IF EXISTS public.page_cms_source_references;

ALTER TABLE public.local_page_cms_source_references RENAME TO page_cms_source_references;

--
-- Name: page_sections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_page_sections (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    cms_data jsonb,
    cms_section_id character varying(255),
    component character varying(255),
    mapped_data jsonb,
    page_id uuid,
    product_source_type character varying(255),
    product_source_value text,
    type character varying(255),
    "order" integer,
    gerx24_component character varying(255),
    cms_component character varying(255),
    content jsonb
);

INSERT INTO public.local_page_sections (id, inserted_at, updated_at, cms_data, cms_section_id, component, mapped_data, page_id, product_source_type, product_source_value, type, "order", gerx24_component, cms_component, content)
SELECT id, inserted_at, updated_at, cms_data, cms_section_id, component, mapped_data, page_id, product_source_type, product_source_value, type, "order", gerx24_component, cms_component, content
FROM public.page_sections;

DROP FOREIGN TABLE IF EXISTS public.page_sections;

ALTER TABLE public.local_page_sections RENAME TO page_sections;

--
-- Name: pages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_pages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    cms_source_id character varying(255),
    cms_source character varying(255),
    description character varying(255),
    layout character varying(255),
    locale character varying(255),
    page_section_order character varying(255)[],
    path character varying(255),
    product_source character varying(255),
    status character varying(255),
    tenant_id uuid,
    title character varying(255),
    type character varying(255),
    metadata jsonb
);

INSERT INTO public.local_pages (id, inserted_at, updated_at, cms_source_id, cms_source, description, layout, locale, page_section_order, path, product_source, status, tenant_id, title, type, metadata)
SELECT id, inserted_at, updated_at, cms_source_id, cms_source, description, layout, locale, page_section_order, path, product_source, status, tenant_id, title, type, metadata
FROM public.pages;

DROP FOREIGN TABLE IF EXISTS public.pages;

ALTER TABLE public.local_pages RENAME TO pages;

--
-- Name: product_details; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_product_details (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    data jsonb NOT NULL,
    locale_language_id uuid,
    product_id bigint
);

INSERT INTO public.local_product_details (id, inserted_at, updated_at, data, locale_language_id, product_id)
SELECT id, inserted_at, updated_at, data, locale_language_id, product_id
FROM public.product_details;

DROP FOREIGN TABLE IF EXISTS public.product_details;

ALTER TABLE public.local_product_details RENAME TO product_details;

--
-- Name: product_variant_details; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_product_variant_details (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    sku character varying(255),
    locale_language_id uuid,
    data jsonb NOT NULL
);

INSERT INTO public.local_product_variant_details (id, inserted_at, updated_at, sku, locale_language_id, data)
SELECT id, inserted_at, updated_at, sku, locale_language_id, data
FROM public.product_variant_details;

DROP FOREIGN TABLE IF EXISTS public.product_variant_details;

ALTER TABLE public.local_product_variant_details RENAME TO product_variant_details;

--
-- Name: product_variants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_product_variants (
    sku character varying(255) NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    product_id bigint,
    material_code character varying(255) NOT NULL,
    upc character varying(255) NOT NULL
);

INSERT INTO public.local_product_variants (sku, inserted_at, updated_at, product_id, material_code, upc)
SELECT sku, inserted_at, updated_at, product_id, material_code, upc
FROM public.product_variants;

DROP FOREIGN TABLE IF EXISTS public.product_variants;

ALTER TABLE public.local_product_variants RENAME TO product_variants;

--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_products (
    id bigint NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    brand_id integer NOT NULL
);

INSERT INTO public.local_products (id, inserted_at, updated_at, brand_id)
SELECT id, inserted_at, updated_at, brand_id
FROM public.products;

DROP FOREIGN TABLE IF EXISTS public.products;

ALTER TABLE public.local_products RENAME TO products;
--
-- Name: regions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_regions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying(255) NOT NULL,
    code character varying(255) NOT NULL,
    number integer NOT NULL
);

INSERT INTO public.local_regions (id, inserted_at, updated_at, name, code, number)
SELECT id, inserted_at, updated_at, name, code, number
FROM public.regions;

DROP FOREIGN TABLE IF EXISTS public.regions;

ALTER TABLE public.local_regions RENAME TO regions;

--
-- Name: regions_data_centers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_regions_data_centers (
    region_id uuid NOT NULL,
    data_center_id uuid NOT NULL
);

INSERT INTO public.local_regions_data_centers (region_id, data_center_id)
SELECT region_id, data_center_id
FROM public.regions_data_centers;

DROP FOREIGN TABLE IF EXISTS public.regions_data_centers;

ALTER TABLE public.local_regions_data_centers RENAME TO regions_data_centers;

--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);

INSERT INTO public.local_schema_migrations (version, inserted_at)
SELECT version, inserted_at
FROM public.schema_migrations;

DROP FOREIGN TABLE IF EXISTS public.schema_migrations;

ALTER TABLE public.local_schema_migrations RENAME TO schema_migrations;

--
-- Name: shopkeeper_audit_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_shopkeeper_audit_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    shopkeeper_id uuid NOT NULL,
    action character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    params jsonb NOT NULL,
    remote_ip text,
    user_agent text
);

INSERT INTO public.local_shopkeeper_audit_logs (id, inserted_at, shopkeeper_id, action, email, params, remote_ip, user_agent)
SELECT id, inserted_at, shopkeeper_id, action, email, params, remote_ip, user_agent
FROM public.shopkeeper_audit_logs;

DROP FOREIGN TABLE IF EXISTS public.shopkeeper_audit_logs;

ALTER TABLE public.local_shopkeeper_audit_logs RENAME TO shopkeeper_audit_logs;

--
-- Name: shopkeeper_scopes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_shopkeeper_scopes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    shopkeeper_id uuid NOT NULL,
    scope character varying(255) NOT NULL,
    brand_id uuid,
    tenant_id uuid
);

INSERT INTO public.local_shopkeeper_scopes (id, inserted_at, updated_at, shopkeeper_id, scope, brand_id, tenant_id)
SELECT id, inserted_at, updated_at, shopkeeper_id, scope, brand_id, tenant_id
FROM public.shopkeeper_scopes;

DROP FOREIGN TABLE IF EXISTS public.shopkeeper_scopes;

ALTER TABLE public.local_shopkeeper_scopes RENAME TO shopkeeper_scopes;

--
-- Name: shopkeeper_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_shopkeeper_sessions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    expires_at timestamp without time zone DEFAULT now() NOT NULL,
    shopkeeper_id uuid NOT NULL,
    token bytea NOT NULL
);

INSERT INTO public.local_shopkeeper_sessions (id, inserted_at, expires_at, shopkeeper_id, token)
SELECT id, inserted_at, expires_at, shopkeeper_id, token
FROM public.shopkeeper_sessions;

DROP FOREIGN TABLE IF EXISTS public.shopkeeper_sessions;

ALTER TABLE public.local_shopkeeper_sessions RENAME TO shopkeeper_sessions;

--
-- Name: shopkeepers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_shopkeepers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    email character varying(255) NOT NULL,
    granted boolean DEFAULT false NOT NULL
);

INSERT INTO public.local_shopkeepers (id, inserted_at, email, granted)
SELECT id, inserted_at, email, granted
FROM public.shopkeepers;

DROP FOREIGN TABLE IF EXISTS public.shopkeepers;

ALTER TABLE public.local_shopkeepers RENAME TO shopkeepers;

--
-- Name: static_assets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_static_assets (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    key text NOT NULL,
    location character varying(255) NOT NULL,
    checksum character varying(255) NOT NULL
);

INSERT INTO public.local_static_assets (id, inserted_at, updated_at, tenant_id, key, location, checksum)
SELECT id, inserted_at, updated_at, tenant_id, key, location, checksum
FROM public.static_assets;

DROP FOREIGN TABLE IF EXISTS public.static_assets;

ALTER TABLE public.local_static_assets RENAME TO static_assets;

--
-- Name: templates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_templates (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    key character varying(255) NOT NULL,
    content bytea NOT NULL,
    checksum character varying(255) NOT NULL
);

INSERT INTO public.local_templates (id, inserted_at, updated_at, tenant_id, key, content, checksum)
SELECT id, inserted_at, updated_at, tenant_id, key, content, checksum
FROM public.templates;

DROP FOREIGN TABLE IF EXISTS public.templates;

ALTER TABLE public.local_templates RENAME TO templates;

--
-- Name: tenants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_tenants (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    domain character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    brand_id uuid,
    percent_of_traffic integer DEFAULT 0
);

INSERT INTO public.local_tenants (id, inserted_at, updated_at, domain, url, brand_id, percent_of_traffic)
SELECT id, inserted_at, updated_at, domain, url, brand_id, percent_of_traffic
FROM public.tenants;

DROP FOREIGN TABLE IF EXISTS public.tenants;

ALTER TABLE public.local_tenants RENAME TO tenants;

--
-- Name: tenants_locales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_tenants_locales (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    locale_id uuid NOT NULL,
    is_default boolean DEFAULT false NOT NULL
);

INSERT INTO public.local_tenants_locales (id, inserted_at, updated_at, tenant_id, locale_id, is_default)
SELECT id, inserted_at, updated_at, tenant_id, locale_id, is_default
FROM public.tenants_locales;

DROP FOREIGN TABLE IF EXISTS public.tenants_locales;

ALTER TABLE public.local_tenants_locales RENAME TO tenants_locales;


--
-- Name: account; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_account (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid,
    version character varying(255) DEFAULT '2'::character varying
);

INSERT INTO settings.local_account (id, inserted_at, updated_at, tenant_id, version)
SELECT id, inserted_at, updated_at, tenant_id, version
FROM settings.account;

DROP FOREIGN TABLE IF EXISTS settings.account;

ALTER TABLE settings.local_account RENAME TO account;


--
-- Name: analytics; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_analytics (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    onetrust_api_key character varying(255) NOT NULL,
    tealium_profile character varying(255) NOT NULL,
    tealium_env character varying(255) NOT NULL,
    tealium_url character varying(255)
);

INSERT INTO settings.local_analytics (id, inserted_at, updated_at, tenant_id, enabled, onetrust_api_key, tealium_profile, tealium_env, tealium_url)
SELECT id, inserted_at, updated_at, tenant_id, enabled, onetrust_api_key, tealium_profile, tealium_env, tealium_url
FROM settings.analytics;

DROP FOREIGN TABLE IF EXISTS settings.analytics;

ALTER TABLE settings.local_analytics RENAME TO analytics;


--
-- Name: carts; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_carts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    page_checkout_url character varying(255) DEFAULT ''::character varying NOT NULL,
    page_go_shopping_url character varying(255) DEFAULT ''::character varying NOT NULL,
    page_is_read_only boolean DEFAULT false NOT NULL,
    drawer_checkout_url character varying(255) DEFAULT ''::character varying NOT NULL,
    drawer_enable_on_drupalgem boolean DEFAULT false NOT NULL,
    drawer_go_shopping_url character varying(255) DEFAULT ''::character varying NOT NULL,
    drawer_is_read_only boolean DEFAULT false NOT NULL,
    remove_free_items boolean DEFAULT false NOT NULL,
    remove_text_button boolean DEFAULT false NOT NULL,
    product_free_label boolean DEFAULT false NOT NULL,
    product_sample_label boolean DEFAULT false NOT NULL,
    drawer_product_title boolean DEFAULT false NOT NULL,
    "overlay" boolean DEFAULT false NOT NULL,
    mini_overlay boolean DEFAULT false NOT NULL,
    mini_overlay_subtotal boolean DEFAULT false NOT NULL,
    mini_overlay_qty_added_on_atb boolean DEFAULT false NOT NULL,
    redirect_to_checkout_on_empty boolean DEFAULT false NOT NULL,
    redirect_to_checkout_on_mobile boolean DEFAULT false NOT NULL,
    drawer_edit_button boolean DEFAULT false NOT NULL,
    overlay_footer_drupal_node_position_on_top boolean DEFAULT false NOT NULL,
    product_added_label boolean DEFAULT false NOT NULL,
    drawer_enable boolean DEFAULT false NOT NULL,
    overlay_footer_drupal_node_id character varying(255)[] DEFAULT ARRAY[]::character varying[],
    page_panel_bottom_node_id character varying(255)[] DEFAULT ARRAY[]::character varying[],
    page_summary_node_id character varying(255)[] DEFAULT ARRAY[]::character varying[],
    page_subtitle_node_id character varying(255)[] DEFAULT ARRAY[]::character varying[],
    enable_kit_details boolean DEFAULT false,
    enable_replenishment boolean DEFAULT false,
    page_payment_icons_node_id integer DEFAULT 0
);

INSERT INTO settings.local_carts (id, inserted_at, updated_at, tenant_id, enabled, page_checkout_url, page_go_shopping_url,
                            page_is_read_only, drawer_checkout_url, drawer_enable_on_drupalgem, drawer_go_shopping_url,
                            drawer_is_read_only, remove_free_items, remove_text_button, product_free_label, product_sample_label,
                            drawer_product_title, overlay, mini_overlay, mini_overlay_subtotal, mini_overlay_qty_added_on_atb,
                            redirect_to_checkout_on_empty, redirect_to_checkout_on_mobile, drawer_edit_button,
                            overlay_footer_drupal_node_position_on_top, product_added_label, drawer_enable,
                            overlay_footer_drupal_node_id, page_panel_bottom_node_id, page_summary_node_id,
                            page_subtitle_node_id, enable_kit_details, enable_replenishment, page_payment_icons_node_id)
SELECT id, inserted_at, updated_at, tenant_id, enabled, page_checkout_url, page_go_shopping_url,
       page_is_read_only, drawer_checkout_url, drawer_enable_on_drupalgem, drawer_go_shopping_url,
       drawer_is_read_only, remove_free_items, remove_text_button, product_free_label, product_sample_label,
       drawer_product_title, overlay, mini_overlay, mini_overlay_subtotal, mini_overlay_qty_added_on_atb,
       redirect_to_checkout_on_empty, redirect_to_checkout_on_mobile, drawer_edit_button,
       overlay_footer_drupal_node_position_on_top, product_added_label, drawer_enable,
       overlay_footer_drupal_node_id, page_panel_bottom_node_id, page_summary_node_id,
       page_subtitle_node_id, enable_kit_details, enable_replenishment, page_payment_icons_node_id
FROM settings.carts;

DROP FOREIGN TABLE IF EXISTS settings.carts;

ALTER TABLE settings.local_carts RENAME TO carts;


--
-- Name: cdns; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_cdns (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT false,
    media_base_url character varying(255) NOT NULL
);

INSERT INTO settings.local_cdns (id, inserted_at, updated_at, tenant_id, enabled, media_base_url)
SELECT id, inserted_at, updated_at, tenant_id, enabled, media_base_url
FROM settings.cdns;

DROP FOREIGN TABLE IF EXISTS settings.cdns;

ALTER TABLE settings.local_cdns RENAME TO cdns;

--
-- Name: checkouts; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_checkouts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    version character varying(255) NOT NULL,
    asset_key character varying(255),
    needs_signin_url character varying(255),
    needs_items_url character varying(255),
    enable_donation boolean DEFAULT false
);

INSERT INTO settings.local_checkouts (id, inserted_at, updated_at, tenant_id, enabled, version, asset_key, needs_signin_url, needs_items_url, enable_donation)
SELECT id, inserted_at, updated_at, tenant_id, enabled, version, asset_key, needs_signin_url, needs_items_url, enable_donation
FROM settings.checkouts;

DROP FOREIGN TABLE IF EXISTS settings.checkouts;

ALTER TABLE settings.local_checkouts RENAME TO checkouts;

--
-- Name: drupals; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_drupals (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    published_base_url character varying(255) NOT NULL,
    auto_import boolean DEFAULT false,
    preview_password character varying(255),
    preview_username character varying(255),
    preview_base_url character varying(255),
    preview_base_url_enabled boolean DEFAULT false
);

INSERT INTO settings.local_drupals (id, inserted_at, updated_at, tenant_id, enabled, published_base_url, auto_import, preview_password, preview_username, preview_base_url, preview_base_url_enabled)
SELECT id, inserted_at, updated_at, tenant_id, enabled, published_base_url, auto_import, preview_password, preview_username, preview_base_url, preview_base_url_enabled
FROM settings.drupals;

DROP FOREIGN TABLE IF EXISTS settings.drupals;

ALTER TABLE settings.local_drupals RENAME TO drupals;

--
-- Name: endecas; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_endecas (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    api_base_url character varying(255) NOT NULL,
    results_per_page character varying(255) DEFAULT '5'::character varying NOT NULL,
    server_name character varying(255),
    server_port character varying(255),
    typeahead_api_base_url character varying(255) DEFAULT ''::character varying,
    search_key character varying(255) DEFAULT 'all'::character varying NOT NULL
);

INSERT INTO settings.local_endecas (id, inserted_at, updated_at, tenant_id, enabled, api_base_url, results_per_page, server_name, server_port, typeahead_api_base_url, search_key)
SELECT id, inserted_at, updated_at, tenant_id, enabled, api_base_url, results_per_page, server_name, server_port, typeahead_api_base_url, search_key
FROM settings.endecas;

DROP FOREIGN TABLE IF EXISTS settings.endecas;

ALTER TABLE settings.local_endecas RENAME TO endecas;

--
-- Name: fredhoppers; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_fredhoppers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    base_search_url character varying(255) NOT NULL,
    base_suggest_url character varying(255) NOT NULL,
    catalog character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    resource_name character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    prepublished_base_search_url character varying(255),
    prepublished_base_search_url_enabled boolean DEFAULT false
);

INSERT INTO settings.local_fredhoppers (
    id, inserted_at, updated_at, tenant_id, enabled,
    base_search_url, base_suggest_url, catalog, password,
    resource_name, username, prepublished_base_search_url,
    prepublished_base_search_url_enabled
)
SELECT
    id, inserted_at, updated_at, tenant_id, enabled,
    base_search_url, base_suggest_url, catalog, password,
    resource_name, username, prepublished_base_search_url,
    prepublished_base_search_url_enabled
FROM settings.fredhoppers;

DROP FOREIGN TABLE IF EXISTS settings.fredhoppers;

ALTER TABLE settings.local_fredhoppers RENAME TO fredhoppers;

--
-- Name: languages; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_languages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    "default" character varying(255) NOT NULL,
    supported character varying(255)[] NOT NULL
);

INSERT INTO settings.local_languages (
    id, inserted_at, updated_at, tenant_id, enabled,
    "default", supported
)
SELECT
    id, inserted_at, updated_at, tenant_id, enabled,
    "default", supported
FROM settings.languages;

DROP FOREIGN TABLE IF EXISTS settings.languages;

ALTER TABLE settings.local_languages RENAME TO languages;

--
-- Name: live_persons; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_live_persons (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    account_number character varying(255) NOT NULL,
    cstatus character varying(255) NOT NULL,
    ctype character varying(255) NOT NULL,
    tag_section character varying(255) NOT NULL,
    lp_button_link_div_id character varying(255) DEFAULT NULL::character varying,
    lp_text_link_div_id character varying(255) DEFAULT NULL::character varying,
    livechat_ui_enabled boolean DEFAULT false NOT NULL,
    livechat_ui_floating_button_text character varying(255),
    livechat_ui_beauty_button_text character varying(255),
    livechat_ui_beauty_button_loading_text character varying(255),
    livechat_ui_support_button_text character varying(255),
    livechat_ui_support_button_loading_text character varying(255),
    livechat_ui_drawer_area_text character varying(255),
    livechat_ui_error_message_text character varying(255),
    livechat_ui_cookie_message_text character varying(255)
);

INSERT INTO settings.local_live_persons (
    id, inserted_at, updated_at, tenant_id, enabled,
    account_number, cstatus, ctype, tag_section,
    lp_button_link_div_id, lp_text_link_div_id, livechat_ui_enabled,
    livechat_ui_floating_button_text, livechat_ui_beauty_button_text,
    livechat_ui_beauty_button_loading_text, livechat_ui_support_button_text,
    livechat_ui_support_button_loading_text, livechat_ui_drawer_area_text,
    livechat_ui_error_message_text, livechat_ui_cookie_message_text
)
SELECT
    id, inserted_at, updated_at, tenant_id, enabled,
    account_number, cstatus, ctype, tag_section,
    lp_button_link_div_id, lp_text_link_div_id, livechat_ui_enabled,
    livechat_ui_floating_button_text, livechat_ui_beauty_button_text,
    livechat_ui_beauty_button_loading_text, livechat_ui_support_button_text,
    livechat_ui_support_button_loading_text, livechat_ui_drawer_area_text,
    livechat_ui_error_message_text, livechat_ui_cookie_message_text
FROM settings.live_persons;

DROP FOREIGN TABLE IF EXISTS settings.live_persons;

ALTER TABLE settings.local_live_persons RENAME TO live_persons;

--
-- Name: loyalties; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_loyalties (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    display_loyalty_points boolean DEFAULT false NOT NULL,
    loyalty_points_multiplier integer DEFAULT 10 NOT NULL
);

INSERT INTO settings.local_loyalties (
    id, inserted_at, updated_at, tenant_id,
    display_loyalty_points, loyalty_points_multiplier
)
SELECT
    id, inserted_at, updated_at, tenant_id,
    display_loyalty_points, loyalty_points_multiplier
FROM settings.loyalties;

DROP FOREIGN TABLE IF EXISTS settings.loyalties;

ALTER TABLE settings.local_loyalties RENAME TO loyalties;

--
-- Name: offers; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_offers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    drawer_enable_offer_code_module boolean NOT NULL,
    page_enable_offer_code_module boolean NOT NULL,
    page_enable_samples_module boolean NOT NULL,
    drawer_enable_samples_module boolean,
    enable_offers_tab boolean,
    rest_auth_token character varying(255)
);

INSERT INTO settings.local_offers (
    id, inserted_at, updated_at, tenant_id,
    enabled, drawer_enable_offer_code_module, page_enable_offer_code_module,
    page_enable_samples_module, drawer_enable_samples_module,
    enable_offers_tab, rest_auth_token
)
SELECT
    id, inserted_at, updated_at, tenant_id,
    enabled, drawer_enable_offer_code_module, page_enable_offer_code_module,
    page_enable_samples_module, drawer_enable_samples_module,
    enable_offers_tab, rest_auth_token
FROM settings.offers;

DROP FOREIGN TABLE IF EXISTS settings.offers;

ALTER TABLE settings.local_offers RENAME TO offers;


--
-- Name: olapics; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_olapics (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    apikey character varying(255) NOT NULL,
    url character varying(255) NOT NULL
);

INSERT INTO settings.local_olapics (
    id, inserted_at, updated_at, tenant_id,
    enabled, apikey, url
)
SELECT
    id, inserted_at, updated_at, tenant_id,
    enabled, apikey, url
FROM settings.olapics;

DROP FOREIGN TABLE IF EXISTS settings.olapics;

ALTER TABLE settings.local_olapics RENAME TO olapics;

--
-- Name: optimizely_sdks; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_optimizely_sdks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    sdk_key character varying(255) DEFAULT ''::character varying NOT NULL
);

INSERT INTO settings.local_optimizely_sdks (
    id, inserted_at, updated_at, tenant_id,
    enabled, sdk_key
)
SELECT
    id, inserted_at, updated_at, tenant_id,
    enabled, sdk_key
FROM settings.optimizely_sdks;

DROP FOREIGN TABLE IF EXISTS settings.optimizely_sdks;

ALTER TABLE settings.local_optimizely_sdks RENAME TO optimizely_sdks;

--
-- Name: optimizelys; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_optimizelys (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    checkout_project_id character varying(255),
    project_id character varying(255),
    js_type character varying(255) DEFAULT 'Web only'::character varying NOT NULL
);

INSERT INTO settings.local_optimizelys (
    id, inserted_at, updated_at, tenant_id, enabled,
    checkout_project_id, project_id, js_type
)
SELECT
    id, inserted_at, updated_at, tenant_id, enabled,
    checkout_project_id, project_id, js_type
FROM settings.optimizelys;

DROP FOREIGN TABLE IF EXISTS settings.optimizelys;

ALTER TABLE settings.local_optimizelys RENAME TO optimizelys;

--
-- Name: perlgems; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_perlgems (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    brand_id integer NOT NULL,
    datacenter character varying(255) NOT NULL,
    region_id integer NOT NULL,
    has_loyalty boolean DEFAULT false
);

INSERT INTO settings.local_perlgems (
    id, inserted_at, updated_at, tenant_id, enabled,
    brand_id, datacenter, region_id, has_loyalty
)
SELECT
    id, inserted_at, updated_at, tenant_id, enabled,
    brand_id, datacenter, region_id, has_loyalty
FROM settings.perlgems;

DROP FOREIGN TABLE IF EXISTS settings.perlgems;

ALTER TABLE settings.local_perlgems RENAME TO perlgems;


--
-- Name: pixlee; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_pixlee (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT false,
    api_key character varying(255) DEFAULT ''::character varying NOT NULL,
    account_id character varying(255) DEFAULT ''::character varying NOT NULL,
    widget_id character varying(255) DEFAULT ''::character varying NOT NULL
);

INSERT INTO settings.local_pixlee (
    id, inserted_at, updated_at, tenant_id, enabled,
    api_key, account_id, widget_id
)
SELECT
    id, inserted_at, updated_at, tenant_id, enabled,
    api_key, account_id, widget_id
FROM settings.pixlee;

DROP FOREIGN TABLE IF EXISTS settings.pixlee;

ALTER TABLE settings.local_pixlee RENAME TO pixlee;

--
-- Name: power_reviews; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_power_reviews (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    apikey character varying(255) NOT NULL,
    base_url character varying(255) NOT NULL,
    merchant_group_id character varying(255) NOT NULL,
    merchant_id character varying(255) NOT NULL
);

INSERT INTO settings.local_power_reviews (
    id, inserted_at, updated_at, tenant_id, enabled,
    apikey, base_url, merchant_group_id, merchant_id
)
SELECT
    id, inserted_at, updated_at, tenant_id, enabled,
    apikey, base_url, merchant_group_id, merchant_id
FROM settings.power_reviews;

DROP FOREIGN TABLE IF EXISTS settings.power_reviews;

ALTER TABLE settings.local_power_reviews RENAME TO power_reviews;

--
-- Name: recommendations; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_recommendations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    page_enable_recommended_for_you boolean NOT NULL,
    drawer_enable_recommended_for_you boolean NOT NULL,
    google_recommendations_enabled boolean DEFAULT false NOT NULL,
    google_recommendations_project_id character varying(255) DEFAULT ''::character varying NOT NULL,
    google_recommendations_api_key character varying(255) DEFAULT ''::character varying NOT NULL,
    abacus_recommendations_enabled boolean DEFAULT false NOT NULL,
    abacus_recommendations_deployment_id character varying(255) DEFAULT ''::character varying NOT NULL,
    abacus_recommendations_deployment_token character varying(255) DEFAULT ''::character varying NOT NULL
);

INSERT INTO settings.local_recommendations (
    id, inserted_at, updated_at, tenant_id, enabled,
    page_enable_recommended_for_you, drawer_enable_recommended_for_you,
    google_recommendations_enabled, google_recommendations_project_id,
    google_recommendations_api_key, abacus_recommendations_enabled,
    abacus_recommendations_deployment_id, abacus_recommendations_deployment_token
)
SELECT
    id, inserted_at, updated_at, tenant_id, enabled,
    page_enable_recommended_for_you, drawer_enable_recommended_for_you,
    google_recommendations_enabled, google_recommendations_project_id,
    google_recommendations_api_key, abacus_recommendations_enabled,
    abacus_recommendations_deployment_id, abacus_recommendations_deployment_token
FROM settings.recommendations;

DROP FOREIGN TABLE IF EXISTS settings.recommendations;

ALTER TABLE settings.local_recommendations RENAME TO recommendations;

--
-- Name: seo; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_seo (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    crawler_exclude_homepage boolean DEFAULT true,
    crawler_exclude_pdp boolean DEFAULT true,
    crawler_exclude_plp boolean DEFAULT true,
    hreflang_enabled boolean DEFAULT false,
    hreflang_default boolean DEFAULT false,
    bidirectional_enabled boolean DEFAULT false
);

INSERT INTO settings.local_seo (
    id, inserted_at, updated_at, tenant_id, crawler_exclude_homepage,
    crawler_exclude_pdp, crawler_exclude_plp, hreflang_enabled,
    hreflang_default, bidirectional_enabled
)
SELECT
    id, inserted_at, updated_at, tenant_id, crawler_exclude_homepage,
    crawler_exclude_pdp, crawler_exclude_plp, hreflang_enabled,
    hreflang_default, bidirectional_enabled
FROM settings.seo;

DROP FOREIGN TABLE IF EXISTS settings.seo;

ALTER TABLE settings.local_seo RENAME TO seo;


--
-- Name: stardusts; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_stardusts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    business_unit_identifier character varying(255) NOT NULL,
    prodcat_api_base_url character varying(255) NOT NULL,
    graphql text DEFAULT ''::text
);

INSERT INTO settings.local_stardusts (
    id, inserted_at, updated_at, tenant_id, enabled,
    business_unit_identifier, prodcat_api_base_url, graphql
)
SELECT
    id, inserted_at, updated_at, tenant_id, enabled,
    business_unit_identifier, prodcat_api_base_url, graphql
FROM settings.stardusts;

DROP FOREIGN TABLE IF EXISTS settings.stardusts;

ALTER TABLE settings.local_stardusts RENAME TO stardusts;


--
-- Name: templates; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_templates (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    name character varying(255) NOT NULL,
    compile_at_startup boolean DEFAULT false
);

INSERT INTO settings.local_templates (
    id, inserted_at, updated_at, tenant_id, enabled,
    name, compile_at_startup
)
SELECT
    id, inserted_at, updated_at, tenant_id, enabled,
    name, compile_at_startup
FROM settings.templates;

DROP FOREIGN TABLE IF EXISTS settings.templates;

ALTER TABLE settings.local_templates RENAME TO templates;


--
-- Name: translation_providers; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_translation_providers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT false,
    password character varying(255),
    username character varying(255)
);

INSERT INTO settings.local_translation_providers (
    id, inserted_at, updated_at, tenant_id, enabled,
    password, username
)
SELECT
    id, inserted_at, updated_at, tenant_id, enabled,
    password, username
FROM settings.translation_providers;

DROP FOREIGN TABLE IF EXISTS settings.translation_providers;

ALTER TABLE settings.local_translation_providers RENAME TO translation_providers;

--
-- Name: turn_to; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_turn_to (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT false,
    site_key character varying(255) DEFAULT ''::character varying NOT NULL
);

INSERT INTO settings.local_turn_to (
    id, inserted_at, updated_at, tenant_id, enabled, site_key
)
SELECT
    id, inserted_at, updated_at, tenant_id, enabled, site_key
FROM settings.turn_to;

DROP FOREIGN TABLE IF EXISTS settings.turn_to;

ALTER TABLE settings.local_turn_to RENAME TO turn_to;


--
-- Name: vtos; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_vtos (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    makeup_api_url character varying(255),
    makeup_api_key character varying(255),
    makeup_enabled boolean DEFAULT false,
    foundation_api_url character varying(255),
    foundation_api_key character varying(255),
    foundation_enabled boolean DEFAULT false,
    skincare_api_url character varying(255),
    skincare_api_key character varying(255),
    skincare_enabled boolean DEFAULT false,
    looks_api_url character varying(255),
    looks_api_key character varying(255),
    looks_enabled boolean DEFAULT false,
    hair_api_url character varying(255),
    hair_api_key character varying(255),
    hair_enabled boolean DEFAULT false,
    enabled boolean
);

INSERT INTO settings.local_vtos (
    id, inserted_at, updated_at, tenant_id, makeup_api_url, makeup_api_key, makeup_enabled,
    foundation_api_url, foundation_api_key, foundation_enabled, skincare_api_url, skincare_api_key,
    skincare_enabled, looks_api_url, looks_api_key, looks_enabled, hair_api_url, hair_api_key,
    hair_enabled, enabled
)
SELECT
    id, inserted_at, updated_at, tenant_id, makeup_api_url, makeup_api_key, makeup_enabled,
    foundation_api_url, foundation_api_key, foundation_enabled, skincare_api_url, skincare_api_key,
    skincare_enabled, looks_api_url, looks_api_key, looks_enabled, hair_api_url, hair_api_key,
    hair_enabled, enabled
FROM settings.vtos;

DROP FOREIGN TABLE IF EXISTS settings.vtos;

ALTER TABLE settings.local_vtos RENAME TO vtos;

--
-- Name: white_labels; Type: TABLE; Schema: settings; Owner: -
--

CREATE TABLE settings.local_white_labels (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    backorder_enabled boolean DEFAULT false NOT NULL,
    cms_provider character varying(255),
    product_provider character varying(255),
    merch_provider character varying(255),
    search_provider character varying(255)
);

INSERT INTO settings.local_white_labels (
    id, inserted_at, updated_at, tenant_id, enabled, backorder_enabled,
    cms_provider, product_provider, merch_provider, search_provider
)
SELECT
    id, inserted_at, updated_at, tenant_id, enabled, backorder_enabled,
    cms_provider, product_provider, merch_provider, search_provider
FROM settings.white_labels;

DROP FOREIGN TABLE IF EXISTS settings.white_labels;

ALTER TABLE settings.local_white_labels RENAME TO white_labels;


ALTER TABLE ONLY client_side.actives
    ADD CONSTRAINT actives_pkey PRIMARY KEY (id);

ALTER TABLE ONLY client_side.mounts
    ADD CONSTRAINT mounts_pkey PRIMARY KEY (id);

ALTER TABLE ONLY client_side.releases
    ADD CONSTRAINT releases_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.api_keys
    ADD CONSTRAINT api_keys_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.api_permissions
    ADD CONSTRAINT api_permissions_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.collection_pages
    ADD CONSTRAINT collection_pages_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.collections
    ADD CONSTRAINT collections_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.content_partials
    ADD CONSTRAINT content_partials_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.data_centers
    ADD CONSTRAINT data_centers_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.fun_with_flags_toggles
    ADD CONSTRAINT fun_with_flags_toggles_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.global_content_cms_source_references
    ADD CONSTRAINT global_content_cms_source_references_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.global_contents
    ADD CONSTRAINT global_contents_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.locale_languages
    ADD CONSTRAINT locale_languages_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.locales
    ADD CONSTRAINT locales_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.offer_versions
    ADD CONSTRAINT offer_versions_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.page_cms_source_references
    ADD CONSTRAINT page_cms_source_references_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.page_sections
    ADD CONSTRAINT page_sections_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.product_details
    ADD CONSTRAINT product_details_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.product_variant_details
    ADD CONSTRAINT product_variant_details_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT product_variants_pkey PRIMARY KEY (sku);

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.regions_data_centers
    ADD CONSTRAINT regions_data_centers_pkey PRIMARY KEY (region_id, data_center_id);

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);

ALTER TABLE ONLY public.shopkeeper_audit_logs
    ADD CONSTRAINT shopkeeper_audit_logs_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.shopkeeper_scopes
    ADD CONSTRAINT shopkeeper_scopes_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.shopkeeper_sessions
    ADD CONSTRAINT shopkeeper_sessions_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.shopkeepers
    ADD CONSTRAINT shopkeepers_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.static_assets
    ADD CONSTRAINT static_assets_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.templates
    ADD CONSTRAINT templates_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.tenants_locales
    ADD CONSTRAINT tenants_locales_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.tenants
    ADD CONSTRAINT tenants_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.analytics
    ADD CONSTRAINT analytics_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.cdns
    ADD CONSTRAINT cdns_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.checkouts
    ADD CONSTRAINT checkouts_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.drupals
    ADD CONSTRAINT drupals_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.endecas
    ADD CONSTRAINT endecas_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.fredhoppers
    ADD CONSTRAINT fredhoppers_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.languages
    ADD CONSTRAINT languages_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.live_persons
    ADD CONSTRAINT live_persons_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.loyalties
    ADD CONSTRAINT loyalties_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.offers
    ADD CONSTRAINT offers_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.olapics
    ADD CONSTRAINT olapics_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.optimizely_sdks
    ADD CONSTRAINT optimizely_sdks_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.optimizelys
    ADD CONSTRAINT optimizelys_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.perlgems
    ADD CONSTRAINT perlgems_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.pixlee
    ADD CONSTRAINT pixlee_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.power_reviews
    ADD CONSTRAINT power_reviews_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.recommendations
    ADD CONSTRAINT recommendations_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.seo
    ADD CONSTRAINT seo_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.stardusts
    ADD CONSTRAINT stardusts_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.templates
    ADD CONSTRAINT templates_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.translation_providers
    ADD CONSTRAINT translation_providers_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.turn_to
    ADD CONSTRAINT turn_to_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.vtos
    ADD CONSTRAINT vtos_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings.white_labels
    ADD CONSTRAINT white_labels_pkey PRIMARY KEY (id);

CREATE UNIQUE INDEX actives_mount_id_index ON client_side.actives USING btree (mount_id);

CREATE UNIQUE INDEX mounts_name_index ON client_side.mounts USING btree (name);

CREATE UNIQUE INDEX releases_mount_id_version_index ON client_side.releases USING btree (mount_id, version);

CREATE INDEX api_keys_token_index ON public.api_keys USING btree (token);

CREATE INDEX api_permissions_api_key_id_index ON public.api_permissions USING btree (api_key_id);

CREATE UNIQUE INDEX api_permissions_api_key_id_tenant_id_index ON public.api_permissions USING btree (api_key_id, tenant_id) WHERE (revoked_at IS NULL);

CREATE UNIQUE INDEX brands_code_index ON public.brands USING btree (code);

CREATE UNIQUE INDEX brands_name_index ON public.brands USING btree (name);

CREATE UNIQUE INDEX brands_number_index ON public.brands USING btree (number);


CREATE INDEX collection_pages_cache_product_data_index ON public.collection_pages USING btree (cache_product_data);

CREATE INDEX collection_pages_collection_id_index ON public.collection_pages USING btree (collection_id);

CREATE UNIQUE INDEX collection_pages_drupal_cms_path_tenant_id_locale_index ON public.collection_pages USING btree (drupal_cms_path, tenant_id, locale);


CREATE UNIQUE INDEX collection_pages_handle_tenant_id_locale_index ON public.collection_pages USING btree (handle, tenant_id, locale);

CREATE INDEX collection_pages_tenant_id_index ON public.collection_pages USING btree (tenant_id);

CREATE INDEX collection_pages_tenant_id_status_index ON public.collection_pages USING btree (tenant_id, status);

CREATE INDEX collections_name_index ON public.collections USING btree (name);

CREATE UNIQUE INDEX content_partials_tenant_id_component_locale_index ON public.content_partials USING btree (tenant_id, component, locale);

CREATE UNIQUE INDEX data_centers_code_index ON public.data_centers USING btree (code);

CREATE UNIQUE INDEX fwf_flag_name_gate_target_idx ON public.fun_with_flags_toggles USING btree (flag_name, gate_type, target);

CREATE UNIQUE INDEX global_content_cms_source_references_tenant_id_locale_index ON public.global_content_cms_source_references USING btree (tenant_id, locale);

CREATE INDEX global_contents_locale_tenant_id_index ON public.global_contents USING btree (locale, tenant_id);

CREATE INDEX global_contents_tenant_id_index ON public.global_contents USING btree (tenant_id);

CREATE INDEX languages_code_index ON public.languages USING btree (code);

CREATE UNIQUE INDEX languages_code_script_index ON public.languages USING btree (code, script);

CREATE INDEX locale_languages_language_id_index ON public.locale_languages USING btree (language_id);

CREATE UNIQUE INDEX locale_languages_locale_id_is_default_index ON public.locale_languages USING btree (locale_id, is_default) WHERE (is_default = true);

CREATE UNIQUE INDEX locale_languages_locale_id_language_id_index ON public.locale_languages USING btree (locale_id, language_id);

CREATE UNIQUE INDEX locales_code_index ON public.locales USING btree (code);

CREATE UNIQUE INDEX locales_number_index ON public.locales USING btree (number);

CREATE UNIQUE INDEX offer_versions_id_offer_id_index ON public.offer_versions USING btree (id, offer_id);

CREATE INDEX offer_versions_inserted_at_offer_id_index ON public.offer_versions USING btree (inserted_at, offer_id);

CREATE UNIQUE INDEX offer_versions_offer_id_version_index ON public.offer_versions USING btree (offer_id, version);

CREATE INDEX offer_versions_version_offer_id_index ON public.offer_versions USING btree (version, offer_id);

CREATE INDEX offers_name_id_index ON public.offers USING btree (code, id);

CREATE UNIQUE INDEX offers_tenant_id_code_index ON public.offers USING btree (tenant_id, code);

CREATE UNIQUE INDEX page_cms_source_references_tenant_id_page_id_index ON public.page_cms_source_references USING btree (tenant_id, page_id);


CREATE INDEX page_sections_page_id_index ON public.page_sections USING btree (page_id);

CREATE INDEX pages_status_index ON public.pages USING btree (status);

CREATE UNIQUE INDEX pages_tenant_id_path_locale_index ON public.pages USING btree (tenant_id, path, locale);

CREATE INDEX pages_tenant_id_type_locale_index ON public.pages USING btree (tenant_id, type, locale);

CREATE INDEX pages_type_index ON public.pages USING btree (type);

CREATE INDEX product_details_locale_language_id_index ON public.product_details USING btree (locale_language_id);

CREATE INDEX product_details_product_id_index ON public.product_details USING btree (product_id);

CREATE UNIQUE INDEX product_details_product_id_locale_language_id_index ON public.product_details USING btree (product_id, locale_language_id);

CREATE INDEX product_variant_details_locale_language_id_index ON public.product_variant_details USING btree (locale_language_id);

CREATE INDEX product_variant_details_sku_index ON public.product_variant_details USING btree (sku);


CREATE UNIQUE INDEX product_variant_details_sku_locale_language_id_index ON public.product_variant_details USING btree (sku, locale_language_id);

CREATE UNIQUE INDEX product_variants_material_code_index ON public.product_variants USING btree (material_code);

CREATE INDEX product_variants_product_id_index ON public.product_variants USING btree (product_id);

CREATE INDEX product_variants_sku_index ON public.product_variants USING btree (sku);


CREATE INDEX products_brand_id_index ON public.products USING btree (brand_id);


CREATE UNIQUE INDEX regions_code_index ON public.regions USING btree (code);

CREATE INDEX regions_data_centers_data_center_id_index ON public.regions_data_centers USING btree (data_center_id);

CREATE UNIQUE INDEX regions_data_centers_region_id_data_center_id_index ON public.regions_data_centers USING btree (region_id, data_center_id);

CREATE INDEX regions_data_centers_region_id_index ON public.regions_data_centers USING btree (region_id);

CREATE UNIQUE INDEX regions_number_index ON public.regions USING btree (number);

CREATE INDEX shopkeeper_audit_logs_action_index ON public.shopkeeper_audit_logs USING btree (action);

CREATE INDEX shopkeeper_audit_logs_inserted_at_index ON public.shopkeeper_audit_logs USING btree (inserted_at);

CREATE INDEX shopkeeper_audit_logs_shopkeeper_id_index ON public.shopkeeper_audit_logs USING btree (shopkeeper_id);

CREATE INDEX shopkeeper_sessions_shopkeeper_id_index ON public.shopkeeper_sessions USING btree (shopkeeper_id);

CREATE INDEX shopkeeper_sessions_token_expires_at_index ON public.shopkeeper_sessions USING btree (token, expires_at);

CREATE UNIQUE INDEX shopkeepers_email_index ON public.shopkeepers USING btree (email);


CREATE INDEX static_assets_tenant_id_index ON public.static_assets USING btree (tenant_id);

CREATE UNIQUE INDEX static_assets_tenant_id_key_index ON public.static_assets USING btree (tenant_id, key);

CREATE INDEX templates_tenant_id_index ON public.templates USING btree (tenant_id);


CREATE UNIQUE INDEX templates_tenant_id_key_index ON public.templates USING btree (tenant_id, key);

CREATE UNIQUE INDEX tenants_domain_index ON public.tenants USING btree (domain);

CREATE INDEX tenants_locales_tenant_id_index ON public.tenants_locales USING btree (tenant_id);

CREATE UNIQUE INDEX tenants_locales_tenant_id_is_default_index ON public.tenants_locales USING btree (tenant_id, is_default) WHERE (is_default = true);

CREATE UNIQUE INDEX tenants_locales_tenant_id_locale_id_index ON public.tenants_locales USING btree (tenant_id, locale_id);


CREATE UNIQUE INDEX account_tenant_id_index ON settings.account USING btree (tenant_id);


CREATE UNIQUE INDEX analytics_tenant_id_index ON settings.analytics USING btree (tenant_id);

CREATE UNIQUE INDEX carts_tenant_id_index ON settings.carts USING btree (tenant_id);


CREATE UNIQUE INDEX cdns_tenant_id_index ON settings.cdns USING btree (tenant_id);


CREATE UNIQUE INDEX checkouts_tenant_id_index ON settings.checkouts USING btree (tenant_id);

CREATE UNIQUE INDEX drupals_tenant_id_index ON settings.drupals USING btree (tenant_id);

CREATE UNIQUE INDEX endecas_tenant_id_index ON settings.endecas USING btree (tenant_id);

CREATE UNIQUE INDEX fredhoppers_tenant_id_index ON settings.fredhoppers USING btree (tenant_id);

CREATE UNIQUE INDEX languages_tenant_id_index ON settings.languages USING btree (tenant_id);

CREATE UNIQUE INDEX live_persons_tenant_id_index ON settings.live_persons USING btree (tenant_id);

CREATE UNIQUE INDEX loyalties_tenant_id_index ON settings.loyalties USING btree (tenant_id);

CREATE UNIQUE INDEX offers_tenant_id_index ON settings.offers USING btree (tenant_id);

CREATE UNIQUE INDEX olapics_tenant_id_index ON settings.olapics USING btree (tenant_id);


CREATE UNIQUE INDEX optimizelys_tenant_id_index ON settings.optimizelys USING btree (tenant_id);

CREATE UNIQUE INDEX perlgems_tenant_id_index ON settings.perlgems USING btree (tenant_id);

CREATE UNIQUE INDEX power_reviews_tenant_id_index ON settings.power_reviews USING btree (tenant_id);


CREATE UNIQUE INDEX recommendations_tenant_id_index ON settings.recommendations USING btree (tenant_id);

CREATE UNIQUE INDEX seo_tenant_id_index ON settings.seo USING btree (tenant_id);


CREATE UNIQUE INDEX stardusts_tenant_id_index ON settings.stardusts USING btree (tenant_id);

CREATE UNIQUE INDEX templates_tenant_id_index ON settings.templates USING btree (tenant_id);

CREATE UNIQUE INDEX translation_providers_tenant_id_index ON settings.translation_providers USING btree (tenant_id);


CREATE UNIQUE INDEX vtos_tenant_id_index ON settings.vtos USING btree (tenant_id);

ALTER TABLE ONLY client_side.actives
    ADD CONSTRAINT actives_mount_id_fkey FOREIGN KEY (mount_id) REFERENCES client_side.mounts(id) ON DELETE CASCADE;

ALTER TABLE ONLY client_side.actives
    ADD CONSTRAINT actives_release_id_fkey FOREIGN KEY (release_id) REFERENCES client_side.releases(id) ON DELETE RESTRICT;

ALTER TABLE ONLY client_side.releases
    ADD CONSTRAINT releases_mount_id_fkey FOREIGN KEY (mount_id) REFERENCES client_side.mounts(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.api_permissions
    ADD CONSTRAINT api_permissions_api_key_id_fkey FOREIGN KEY (api_key_id) REFERENCES public.api_keys(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.api_permissions
    ADD CONSTRAINT api_permissions_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.collection_pages
    ADD CONSTRAINT collection_pages_brand_id_fkey FOREIGN KEY (brand_id) REFERENCES public.brands(id);

ALTER TABLE ONLY public.collection_pages
    ADD CONSTRAINT collection_pages_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES public.collections(id);

-- ALTER TABLE ONLY public.collection_pages
--     ADD CONSTRAINT collection_pages_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.content_partials
    ADD CONSTRAINT content_partials_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);

ALTER TABLE ONLY public.global_content_cms_source_references
    ADD CONSTRAINT global_content_cms_source_references_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.global_contents
    ADD CONSTRAINT global_contents_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;


ALTER TABLE ONLY public.locale_languages
    ADD CONSTRAINT locale_languages_language_id_fkey FOREIGN KEY (language_id) REFERENCES public.languages(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY public.locale_languages
    ADD CONSTRAINT locale_languages_locale_id_fkey FOREIGN KEY (locale_id) REFERENCES public.locales(id);

ALTER TABLE ONLY public.locales
    ADD CONSTRAINT locales_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.regions(id);


ALTER TABLE ONLY public.offer_versions
    ADD CONSTRAINT offer_versions_offer_id_fkey FOREIGN KEY (offer_id) REFERENCES public.offers(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_active_version_id_fkey FOREIGN KEY (active_version_id, id) REFERENCES public.offer_versions(id, offer_id);


ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.page_cms_source_references
    ADD CONSTRAINT page_cms_source_references_page_id_fkey FOREIGN KEY (page_id) REFERENCES public.pages(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.page_cms_source_references
    ADD CONSTRAINT page_cms_source_references_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;


ALTER TABLE ONLY public.page_sections
    ADD CONSTRAINT page_sections_page_id_fkey FOREIGN KEY (page_id) REFERENCES public.pages(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);

ALTER TABLE ONLY public.product_details
    ADD CONSTRAINT product_details_locale_language_id_fkey FOREIGN KEY (locale_language_id) REFERENCES public.locale_languages(id) ON DELETE CASCADE;


ALTER TABLE ONLY public.product_details
    ADD CONSTRAINT product_details_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


ALTER TABLE ONLY public.product_variant_details
    ADD CONSTRAINT product_variant_details_locale_language_id_fkey FOREIGN KEY (locale_language_id) REFERENCES public.locale_languages(id) ON DELETE CASCADE;


ALTER TABLE ONLY public.product_variant_details
    ADD CONSTRAINT product_variant_details_sku_fkey FOREIGN KEY (sku) REFERENCES public.product_variants(sku) ON DELETE CASCADE;

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT product_variants_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_brand_id_fkey FOREIGN KEY (brand_id) REFERENCES public.brands(number) ON DELETE CASCADE;


ALTER TABLE ONLY public.regions_data_centers
    ADD CONSTRAINT regions_data_centers_data_center_id_fkey FOREIGN KEY (data_center_id) REFERENCES public.data_centers(id) ON DELETE CASCADE;


ALTER TABLE ONLY public.regions_data_centers
    ADD CONSTRAINT regions_data_centers_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.regions(id) ON DELETE CASCADE;


ALTER TABLE ONLY public.shopkeeper_audit_logs
    ADD CONSTRAINT shopkeeper_audit_logs_shopkeeper_id_fkey FOREIGN KEY (shopkeeper_id) REFERENCES public.shopkeepers(id) ON UPDATE CASCADE ON DELETE RESTRICT;


ALTER TABLE ONLY public.shopkeeper_scopes
    ADD CONSTRAINT shopkeeper_scopes_brand_id_fkey FOREIGN KEY (brand_id) REFERENCES public.brands(id) ON DELETE CASCADE;


ALTER TABLE ONLY public.shopkeeper_scopes
    ADD CONSTRAINT shopkeeper_scopes_shopkeeper_id_fkey FOREIGN KEY (shopkeeper_id) REFERENCES public.shopkeepers(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY public.shopkeeper_scopes
    ADD CONSTRAINT shopkeeper_scopes_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;


ALTER TABLE ONLY public.shopkeeper_sessions
    ADD CONSTRAINT shopkeeper_sessions_shopkeeper_id_fkey FOREIGN KEY (shopkeeper_id) REFERENCES public.shopkeepers(id) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE ONLY public.static_assets
    ADD CONSTRAINT static_assets_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.templates
    ADD CONSTRAINT templates_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.tenants
    ADD CONSTRAINT tenants_brand_id_fkey FOREIGN KEY (brand_id) REFERENCES public.brands(id);

ALTER TABLE ONLY public.tenants_locales
    ADD CONSTRAINT tenants_locales_locale_id_fkey FOREIGN KEY (locale_id) REFERENCES public.locales(id) ON DELETE CASCADE;


ALTER TABLE ONLY public.tenants_locales
    ADD CONSTRAINT tenants_locales_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;


ALTER TABLE ONLY settings.account
    ADD CONSTRAINT account_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY settings.analytics
    ADD CONSTRAINT analytics_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY settings.carts
    ADD CONSTRAINT carts_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;


ALTER TABLE ONLY settings.cdns
    ADD CONSTRAINT cdns_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY settings.checkouts
    ADD CONSTRAINT checkouts_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY settings.drupals
    ADD CONSTRAINT drupals_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY settings.endecas
    ADD CONSTRAINT endecas_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY settings.fredhoppers
    ADD CONSTRAINT fredhoppers_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY settings.languages
    ADD CONSTRAINT languages_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;


ALTER TABLE ONLY settings.live_persons
    ADD CONSTRAINT live_persons_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY settings.loyalties
    ADD CONSTRAINT loyalties_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY settings.offers
    ADD CONSTRAINT offers_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;


ALTER TABLE ONLY settings.olapics
    ADD CONSTRAINT olapics_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;


ALTER TABLE ONLY settings.optimizely_sdks
    ADD CONSTRAINT optimizely_sdks_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY settings.optimizelys
    ADD CONSTRAINT optimizelys_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY settings.perlgems
    ADD CONSTRAINT perlgems_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY settings.pixlee
    ADD CONSTRAINT pixlee_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY settings.power_reviews
    ADD CONSTRAINT power_reviews_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY settings.recommendations
    ADD CONSTRAINT recommendations_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY settings.seo
    ADD CONSTRAINT seo_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY settings.stardusts
    ADD CONSTRAINT stardusts_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY settings.templates
    ADD CONSTRAINT templates_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY settings.translation_providers
    ADD CONSTRAINT translation_providers_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;


ALTER TABLE ONLY settings.turn_to
    ADD CONSTRAINT turn_to_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY settings.vtos
    ADD CONSTRAINT vtos_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;

ALTER TABLE ONLY settings.white_labels
    ADD CONSTRAINT white_labels_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;
