<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                exclude-result-prefixes="tei">

<xsl:output method="html" encoding="UTF-8" indent="yes" doctype-public="-//W3C//DTD HTML 4.01//EN"/>

<xsl:param name="documentId" select="'unknown'"/>

<xsl:template match="/">
<html lang="de">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title><xsl:value-of select="//tei:title"/> - Austrian Baroque Corpus</title>
    <link rel="stylesheet" href="styles.css"/>
</head>
<body>
    <div class="container">
        <nav class="navigation">
            <div class="nav-links">
                <a href="persons_register.html" class="nav-link">
                    <span class="nav-icon">👥</span>
                    Register der Personen
                </a>
                <a href="places_register.html" class="nav-link">
                    <span class="nav-icon">🗺️</span>
                    Register der Orte
                </a>
                <a href="taxonomy.html" class="nav-link">
                    <span class="nav-icon">📚</span>
                    Taxonomie
                </a>
                <a href="documents.html" class="nav-link">
                    <span class="nav-icon">📖</span>
                    Dokumente
                </a>
            </div>
        </nav>

        <header>
            <div class="document-breadcrumb">
                <a href="documents.html">Dokumente</a> →
                <span><xsl:value-of select="//tei:titleStmt/tei:title"/></span>
            </div>
            <h1 class="header-title"><xsl:value-of select="//tei:titleStmt/tei:title"/></h1>
            <div class="header-subtitle">
                <xsl:value-of select="//tei:titleStmt/tei:author"/>
                <xsl:if test="//tei:publicationStmt/tei:date">
                    • <xsl:value-of select="//tei:publicationStmt/tei:date"/>
                </xsl:if>
            </div>
        </header>

        <div class="document-controls">
            <div class="view-controls">
                <button class="btn btn-secondary active" id="readingView">Leseansicht</button>
                <button class="btn btn-secondary" id="annotationView">Mit Annotation</button>
                <button class="btn btn-secondary" id="metadataView">Metadaten</button>
            </div>
            <div class="search-controls">
                <input type="text" class="search-box" placeholder="Im Dokument suchen..." id="documentSearch"/>
                <select class="filter-select" id="annotationFilter">
                    <option value="all">Alle Annotationen</option>
                    <option value="persons">Personen</option>
                    <option value="places">Orte</option>
                    <option value="pos">POS-Tags</option>
                </select>
            </div>
        </div>

        <div class="document-stats">
            <div class="stat-item">
                <div class="stat-number"><xsl:value-of select="//tei:measure[@type='tokens']"/></div>
                <div class="stat-label">Tokens</div>
            </div>
            <div class="stat-item">
                <div class="stat-number"><xsl:value-of select="count(//tei:pb)"/></div>
                <div class="stat-label">Seiten</div>
            </div>
            <div class="stat-item">
                <div class="stat-number"><xsl:value-of select="count(//tei:persName)"/></div>
                <div class="stat-label">Personennamen</div>
            </div>
            <div class="stat-item">
                <div class="stat-number"><xsl:value-of select="count(//tei:placeName)"/></div>
                <div class="stat-label">Ortsnamen</div>
            </div>
        </div>

        <!-- Document Content -->
        <div id="documentContent" class="document-reader">
            <xsl:apply-templates select="//tei:text"/>
        </div>

        <!-- Metadata Panel (hidden by default) -->
        <div id="metadataPanel" class="metadata-panel hidden">
            <h2>Dokumentmetadaten</h2>

            <div class="metadata-section">
                <h3>Bibliographische Angaben</h3>
                <div class="metadata-grid">
                    <div class="metadata-item">
                        <span class="metadata-label">Titel:</span>
                        <span class="metadata-value"><xsl:value-of select="//tei:titleStmt/tei:title"/></span>
                    </div>
                    <div class="metadata-item">
                        <span class="metadata-label">Autor:</span>
                        <span class="metadata-value"><xsl:value-of select="//tei:titleStmt/tei:author"/></span>
                    </div>
                    <xsl:if test="//tei:publicationStmt/tei:pubPlace">
                        <div class="metadata-item">
                            <span class="metadata-label">Erscheinungsort:</span>
                            <span class="metadata-value"><xsl:value-of select="//tei:publicationStmt/tei:pubPlace"/></span>
                        </div>
                    </xsl:if>
                    <xsl:if test="//tei:publicationStmt/tei:date">
                        <div class="metadata-item">
                            <span class="metadata-label">Erscheinungsjahr:</span>
                            <span class="metadata-value"><xsl:value-of select="//tei:publicationStmt/tei:date"/></span>
                        </div>
                    </xsl:if>
                    <xsl:if test="//tei:extent/tei:measure[@type='pages']">
                        <div class="metadata-item">
                            <span class="metadata-label">Seitenumfang:</span>
                            <span class="metadata-value"><xsl:value-of select="//tei:extent/tei:measure[@type='pages']"/></span>
                        </div>
                    </xsl:if>
                </div>
            </div>

            <xsl:if test="//tei:msIdentifier">
                <div class="metadata-section">
                    <h3>Handschriftliche Überlieferung</h3>
                    <div class="metadata-grid">
                        <xsl:if test="//tei:msIdentifier/tei:settlement">
                            <div class="metadata-item">
                                <span class="metadata-label">Ort:</span>
                                <span class="metadata-value"><xsl:value-of select="//tei:msIdentifier/tei:settlement"/></span>
                            </div>
                        </xsl:if>
                        <xsl:if test="//tei:msIdentifier/tei:institution">
                            <div class="metadata-item">
                                <span class="metadata-label">Institution:</span>
                                <span class="metadata-value"><xsl:value-of select="//tei:msIdentifier/tei:institution"/></span>
                            </div>
                        </xsl:if>
                        <xsl:if test="//tei:msIdentifier/tei:idno">
                            <div class="metadata-item">
                                <span class="metadata-label">Signatur:</span>
                                <span class="metadata-value"><xsl:value-of select="//tei:msIdentifier/tei:idno"/></span>
                            </div>
                        </xsl:if>
                    </div>
                </div>
            </xsl:if>
        </div>
    </div>

    <script>
    <xsl:text disable-output-escaping="yes"><![CDATA[
        const readingView = document.getElementById('readingView');
        const annotationView = document.getElementById('annotationView');
        const metadataView = document.getElementById('metadataView');
        const documentContent = document.getElementById('documentContent');
        const metadataPanel = document.getElementById('metadataPanel');
        const documentSearch = document.getElementById('documentSearch');
        const annotationFilter = document.getElementById('annotationFilter');

        let currentView = 'reading';

        function switchView(viewType) {
            // Reset all buttons
            [readingView, annotationView, metadataView].forEach(btn => btn.classList.remove('active'));

            if (viewType === 'reading') {
                readingView.classList.add('active');
                documentContent.classList.remove('hidden');
                metadataPanel.classList.add('hidden');
                documentContent.classList.remove('annotation-mode');
                currentView = 'reading';
            } else if (viewType === 'annotation') {
                annotationView.classList.add('active');
                documentContent.classList.remove('hidden');
                metadataPanel.classList.add('hidden');
                documentContent.classList.add('annotation-mode');
                currentView = 'annotation';
            } else if (viewType === 'metadata') {
                metadataView.classList.add('active');
                documentContent.classList.add('hidden');
                metadataPanel.classList.remove('hidden');
                currentView = 'metadata';
            }
        }

        readingView.addEventListener('click', () => switchView('reading'));
        annotationView.addEventListener('click', () => switchView('annotation'));
        metadataView.addEventListener('click', () => switchView('metadata'));

        // Search functionality
        documentSearch.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase().trim();
            const textElements = documentContent.querySelectorAll('p, .text-line');

            textElements.forEach(element => {
                const text = element.textContent.toLowerCase();
                if (!searchTerm || text.includes(searchTerm)) {
                    element.style.display = '';
                    if (searchTerm) {
                        element.innerHTML = element.innerHTML.replace(
                            new RegExp(`(${searchTerm})`, 'gi'),
                            '<mark>$1</mark>'
                        );
                    }
                } else {
                    element.style.display = 'none';
                }
            });
        });

        // Annotation filtering
        annotationFilter.addEventListener('change', function() {
            const filterType = this.value;
            const annotations = documentContent.querySelectorAll('.person-annotation, .place-annotation, .pos-annotation');

            if (filterType === 'all') {
                annotations.forEach(ann => ann.style.display = '');
            } else {
                annotations.forEach(ann => {
                    if (ann.classList.contains(`${filterType.slice(0, -1)}-annotation`)) {
                        ann.style.display = '';
                    } else {
                        ann.style.display = 'none';
                    }
                });
            }
        });

        // Initialize reading view
        switchView('reading');

        // Register data for infobox functionality
        // Contains key persons and places found in the annotated documents
        const registerData = {
            persons: {
                'augustinus': {
                    name: 'Augustinus von Hippo',
                    variants: ['Augustine', 'Augustini', 'Sankt Augustinus'],
                    mentions: ['AFH', 'ALW', 'AMW'],
                    type: 'hist',
                    description: 'Kirchenvater und Philosoph (354-430)'
                },
                'eva1': {
                    name: 'Eva',
                    variants: ['Eve', 'Hava'],
                    mentions: ['AFH'],
                    type: 'bibl',
                    description: 'Erste Frau im Alten Testament'
                },
                'melchiorHaan': {
                    name: 'Melchior Haan',
                    variants: ['Haan'],
                    mentions: ['AFH'],
                    type: 'hist',
                    description: 'Salzburger Drucker (17. Jahrhundert)'
                }
                // Additional persons can be added here as needed
            },
            places: {
                'hung': {
                    name: 'Ungarn',
                    variants: ['Hungary', 'Hungaria', 'Magyar'],
                    mentions: ['AFH', 'ALW'],
                    type: 'coun',
                    coordinates: '47.0 19.0',
                    description: 'Königreich in Mitteleuropa'
                },
                'salzburg': {
                    name: 'Salzburg',
                    variants: ['Saltzburg'],
                    mentions: ['AFH'],
                    type: 'city',
                    coordinates: '47.8 13.0',
                    description: 'Stadt im heutigen Österreich'
                }
                // Additional places can be added here as needed
            }
        };

        // Create and display infobox for person or place annotations
        function showInfobox(type, key, element) {
            console.log('showInfobox called with type:', type, 'key:', key);

            const data = registerData[type + 's'][key];
            if (!data) {
                // Fallback for missing entries
                const fallbackData = {
                    name: key.charAt(0).toUpperCase() + key.slice(1),
                    variants: [],
                    mentions: ['Dokument'],
                    type: type === 'person' ? 'hist' : 'place',
                    description: `${type === 'person' ? 'Person' : 'Ort'} aus dem Corpus`
                };
                console.log(`Using fallback data for ${type}: ${key}`);
                createInfoboxHTML(type, key, fallbackData);
                return;
            }

            console.log('Found data for', key, ':', data);
            createInfoboxHTML(type, key, data);
        }

        // Generate infobox HTML and display it
        function createInfoboxHTML(type, key, data) {
            const overlay = document.createElement('div');
            overlay.className = 'infobox-overlay';

            // Build HTML sections
            const header = buildHeader(data, type);
            const details = buildDetails(key, data, type);
            const variants = data.variants.length > 0 ? buildVariants(data.variants) : '';
            const mentions = data.mentions.length > 0 ? buildMentions(data.mentions) : '';

            overlay.innerHTML =
                '<div class="infobox ' + type + '-infobox">' +
                header +
                '<div class="infobox-content">' + details + variants + mentions + '</div>' +
                '</div>';

            document.body.appendChild(overlay);
            setupCloseHandlers(overlay);
        }

        // Helper functions for building HTML sections
        function buildHeader(data, type) {
            return '<div class="infobox-header">' +
                   '<button class="infobox-close">✕</button>' +
                   '<h2 class="infobox-title">' + data.name + '</h2>' +
                   '<p class="infobox-subtitle">' + (data.description || (type === 'person' ? 'Person' : 'Ort')) + ' • ' + data.type + '</p>' +
                   '</div>';
        }

        function buildDetails(key, data, type) {
            let html = '<div class="infobox-section"><h3 class="infobox-section-title">Details</h3>';
            html += '<div class="infobox-detail"><span class="infobox-label">Schlüssel:</span><span class="infobox-value">' + key + '</span></div>';
            html += '<div class="infobox-detail"><span class="infobox-label">Typ:</span><span class="infobox-value">' + data.type;
            if (type === 'place') {
                html += '<span class="place-type-badge">' + data.type + '</span>';
            }
            html += '</span></div>';
            if (data.coordinates) {
                html += '<div class="infobox-detail"><span class="infobox-label">Koordinaten:</span><span class="infobox-value">' + data.coordinates + '</span></div>';
            }
            return html + '</div>';
        }

        function buildVariants(variants) {
            let html = '<div class="infobox-section"><h3 class="infobox-section-title">Namensvarianten</h3><div class="infobox-variants">';
            variants.forEach(function(variant) {
                html += '<span class="variant-tag">' + variant + '</span>';
            });
            return html + '</div></div>';
        }

        function buildMentions(mentions) {
            let html = '<div class="infobox-section"><h3 class="infobox-section-title">Erwähnungen</h3>';
            html += '<div class="infobox-mentions"><p><strong>' + mentions.length + '</strong> Erwähnungen in den Dokumenten:</p>';
            html += '<div class="mentions-list">';
            mentions.forEach(function(mention) {
                html += '<span class="mention-tag">' + mention + '</span>';
            });
            return html + '</div></div></div>';
        }

        // Setup close functionality for infobox
        function setupCloseHandlers(overlay) {

            // Close functionality
            const closeBtn = overlay.querySelector('.infobox-close');
            closeBtn.addEventListener('click', () => {
                document.body.removeChild(overlay);
            });

            overlay.addEventListener('click', (e) => {
                if (e.target === overlay) {
                    document.body.removeChild(overlay);
                }
            });

            // Escape key to close
            const escapeHandler = (e) => {
                if (e.key === 'Escape') {
                    if (document.body.contains(overlay)) {
                        document.body.removeChild(overlay);
                    }
                    document.removeEventListener('keydown', escapeHandler);
                }
            };
            document.addEventListener('keydown', escapeHandler);
        }

        // Setup click handlers for person and place annotations
        function setupAnnotationHandlers() {
            const personAnnotations = document.querySelectorAll('.person-annotation');
            const placeAnnotations = document.querySelectorAll('.place-annotation');

            console.log('Setting up handlers for', personAnnotations.length, 'person annotations and', placeAnnotations.length, 'place annotations');

            // Setup person annotation handlers
            personAnnotations.forEach(element => {
                const key = element.getAttribute('data-key');
                if (key) {
                    element.addEventListener('click', handleAnnotationClick('person', key, element));
                    element.style.cursor = 'pointer';
                }
            });

            // Setup place annotation handlers
            placeAnnotations.forEach(element => {
                const key = element.getAttribute('data-key');
                if (key) {
                    element.addEventListener('click', handleAnnotationClick('place', key, element));
                    element.style.cursor = 'pointer';
                }
            });
        }

        // Create click handler for annotations
        function handleAnnotationClick(type, key, element) {
            return function(e) {
                e.preventDefault();
                e.stopPropagation();
                showInfobox(type, key, element);
            };
        }

        // Initialize when DOM is fully loaded
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', function() {
                setupAnnotationHandlers();
                console.log('Infobox handlers initialized for', document.querySelectorAll('.person-annotation, .place-annotation').length, 'annotations');
            });
        } else {
            // DOM is already loaded
            setupAnnotationHandlers();
            console.log('Infobox handlers initialized for', document.querySelectorAll('.person-annotation, .place-annotation').length, 'annotations');
        }
    ]]></xsl:text>
    </script>
</body>
</html>
</xsl:template>

<!-- Template for processing text content -->
<xsl:template match="tei:text">
    <xsl:apply-templates select="tei:front | tei:body | tei:back"/>
</xsl:template>

<xsl:template match="tei:front | tei:body | tei:back">
    <div class="text-section {local-name()}">
        <xsl:apply-templates/>
    </div>
</xsl:template>

<!-- Page breaks -->
<xsl:template match="tei:pb">
    <div class="page-break" data-page="{@n}" id="{@xml:id}">
        <span class="page-number">Seite <xsl:value-of select="@n"/></span>
        <xsl:if test="@facs">
            <a href="#" class="facsimile-link" title="Faksimile anzeigen">🖼️</a>
        </xsl:if>
    </div>
</xsl:template>

<!-- Paragraphs -->
<xsl:template match="tei:p">
    <p class="text-paragraph">
        <xsl:apply-templates/>
    </p>
</xsl:template>

<!-- Line breaks -->
<xsl:template match="tei:lb">
    <br/>
</xsl:template>

<!-- Words with linguistic annotation -->
<xsl:template match="tei:w">
    <span class="word-annotation" data-lemma="{@lemma}" data-pos="{@type}" data-id="{@xml:id}">
        <span class="word-text"><xsl:apply-templates/></span>
        <span class="pos-annotation hidden">[<xsl:value-of select="@type"/>]</span>
        <span class="lemma-annotation hidden">(<xsl:value-of select="@lemma"/>)</span>
        <!-- Only add tooltip if not inside persName or placeName -->
        <xsl:if test="not(ancestor::tei:persName) and not(ancestor::tei:placeName)">
            <span class="annotation-tooltip hidden">
                Lemma: <xsl:value-of select="@lemma"/> | POS: <xsl:value-of select="@type"/>
            </span>
        </xsl:if>
    </span>
</xsl:template>

<!-- Person names -->
<xsl:template match="tei:persName">
    <span class="person-annotation" data-key="{@key}" data-type="{@type}">
        <xsl:apply-templates/>
        <span class="annotation-tooltip hidden">
            Person: <xsl:value-of select="@key"/> (<xsl:value-of select="@type"/>)
        </span>
    </span>
</xsl:template>

<!-- Place names -->
<xsl:template match="tei:placeName">
    <span class="place-annotation" data-key="{@key}" data-type="{@type}" data-subtype="{@subtype}">
        <xsl:apply-templates/>
        <span class="annotation-tooltip hidden">
            Ort: <xsl:value-of select="@key"/> (<xsl:value-of select="@type"/>)
        </span>
    </span>
</xsl:template>

<!-- Punctuation -->
<xsl:template match="tei:pc">
    <xsl:apply-templates/>
</xsl:template>

<!-- Whitespace preservation -->
<xsl:template match="tei:seg[@type='whitespace']">
    <xsl:value-of select="."/>
</xsl:template>

<!-- Rendering attributes -->
<xsl:template match="tei:seg[@rend]">
    <span class="rend-{@rend}">
        <xsl:apply-templates/>
    </span>
</xsl:template>

<!-- Title page -->
<xsl:template match="tei:titlePage">
    <div class="title-page">
        <xsl:apply-templates/>
    </div>
</xsl:template>

<xsl:template match="tei:docTitle">
    <div class="doc-title">
        <xsl:apply-templates/>
    </div>
</xsl:template>

<xsl:template match="tei:titlePart">
    <div class="title-part title-part-{@type}">
        <xsl:apply-templates/>
    </div>
</xsl:template>

<!-- Figures -->
<xsl:template match="tei:figure">
    <div class="figure">
        <xsl:apply-templates/>
    </div>
</xsl:template>

<!-- Default template for unmatched elements -->
<xsl:template match="*">
    <xsl:apply-templates/>
</xsl:template>

</xsl:stylesheet>