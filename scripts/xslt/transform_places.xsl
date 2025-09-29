<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                exclude-result-prefixes="tei">

<xsl:output method="html" encoding="UTF-8" indent="yes" doctype-public="-//W3C//DTD HTML 4.01//EN"/>

<xsl:template match="/">
<html lang="de">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title><xsl:value-of select="//tei:title[@level='a']"/> - <xsl:value-of select="//tei:title[@level='s']"/></title>
    <link rel="stylesheet" href="styles.css"/>
</head>
<body>
    <div class="container">
        <nav class="navigation">
            <div class="nav-links">
                <a href="index.html" class="nav-link">
                    <span class="nav-icon">🏠</span>
                    Startseite
                </a>
                <a href="persons_register.html" class="nav-link">
                    <span class="nav-icon">👥</span>
                    Register der Personen
                </a>
                <a href="places_register.html" class="nav-link active">
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
            <h1 class="header-title"><xsl:value-of select="//tei:title[@level='a']"/></h1>
            <div class="header-subtitle"><xsl:value-of select="//tei:title[@level='s']"/></div>
            <div class="credits">
                Herausgegeben von:
                <xsl:for-each select="//tei:respStmt[tei:resp[@xml:lang='de']='herausgegeben von']/tei:name">
                    <xsl:value-of select="."/>
                    <xsl:if test="position() != last()">, </xsl:if>
                </xsl:for-each>
            </div>
        </header>

        <div class="controls">
            <input type="text" class="search-box" placeholder="Ort suchen..." id="searchBox"/>
            <select class="sort-select" id="sortSelect">
                <option value="name">Nach Name sortieren</option>
                <option value="mentions-desc">Meiste Erwähnungen</option>
                <option value="mentions-asc">Wenigste Erwähnungen</option>
                <option value="type">Nach Typ sortieren</option>
            </select>
            <select class="filter-select" id="filterSelect">
                <option value="all">Alle Quellen</option>
                <option value="Abraham-Augustini_feuriges_Hertz.xml">Augustini feuriges Hertz</option>
                <option value="Abraham-Loesch_Wienn.xml">Loesch Wienn</option>
                <option value="Abraham-Mercks_Wien.xml">Mercks Wien</option>
                <option value="Abraham-Todten_Capelle.xml">Todten Capelle</option>
                <option value="Abraham-Todten_Bruderschaft.xml">Todten Bruderschaft</option>
            </select>
            <select class="type-filter-select" id="typeFilterSelect">
                <option value="all">Alle Ortstypen</option>
                <option value="city">Städte</option>
                <option value="country">Länder</option>
                <option value="region">Regionen</option>
                <option value="mountain">Berge</option>
                <option value="river">Flüsse</option>
                <option value="building">Gebäude</option>
            </select>
        </div>

        <div class="stats">
            <div class="stat-item">
                <div class="stat-number" id="totalPlaces"><xsl:value-of select="count(//tei:place)"/></div>
                <div class="stat-label">Orte gesamt</div>
            </div>
            <div class="stat-item">
                <div class="stat-number" id="totalMentions">
                    <xsl:value-of select="sum(//tei:note[contains(@type, 'mentions') and not(@target)]/@n)"/>
                </div>
                <div class="stat-label">Erwähnungen gesamt</div>
            </div>
            <div class="stat-item">
                <div class="stat-number" id="sourceFiles">5</div>
                <div class="stat-label">Quelldateien</div>
            </div>
            <div class="stat-item">
                <div class="stat-number" id="visiblePlaces"><xsl:value-of select="count(//tei:place)"/></div>
                <div class="stat-label">Sichtbare Orte</div>
            </div>
        </div>

        <div class="person-grid" id="placeGrid">
            <xsl:for-each select="//tei:place">
                <xsl:sort select="tei:placeName[@type='main']" order="ascending"/>
                <div class="person-card place-card"
                     data-name="{translate(tei:placeName[@type='main'], 'ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜ', 'abcdefghijklmnopqrstuvwxyzäöü')}"
                     data-mentions="{tei:noteGrp/tei:note[not(@target)]/@n}"
                     data-sources="{translate(concat(tei:noteGrp/tei:note[@target][1]/@target, ' ', tei:noteGrp/tei:note[@target][2]/@target, ' ', tei:noteGrp/tei:note[@target][3]/@target, ' ', tei:noteGrp/tei:note[@target][4]/@target, ' ', tei:noteGrp/tei:note[@target][5]/@target), '  ', ' ')}"
                     data-type="{@type}">

                    <div class="person-name place-name">
                        <xsl:value-of select="tei:placeName[@type='main']"/>
                        <xsl:if test="@type">
                            <span class="place-type-badge">
                                <xsl:choose>
                                    <xsl:when test="@type='city'">Stadt</xsl:when>
                                    <xsl:when test="@type='country'">Land</xsl:when>
                                    <xsl:when test="@type='region'">Region</xsl:when>
                                    <xsl:when test="@type='mountain'">Berg</xsl:when>
                                    <xsl:when test="@type='river'">Fluss</xsl:when>
                                    <xsl:when test="@type='building'">Gebäude</xsl:when>
                                    <xsl:otherwise><xsl:value-of select="@type"/></xsl:otherwise>
                                </xsl:choose>
                            </span>
                        </xsl:if>
                    </div>

                    <div class="person-mentions place-mentions">
                        <xsl:value-of select="tei:noteGrp/tei:note[not(@target)]/@n"/> Erwähnungen
                    </div>

                    <xsl:if test="tei:placeName[@type='variation']">
                        <div class="variations">
                            <div class="variations-label">Varianten:</div>
                            <div class="variations-list">
                                <xsl:for-each select="tei:placeName[@type='variation']">
                                    <span class="variation-tag">
                                        <xsl:value-of select="normalize-space(.)"/>
                                    </span>
                                </xsl:for-each>
                            </div>
                        </div>
                    </xsl:if>

                    <xsl:if test="tei:noteGrp/tei:note[@target]">
                        <div class="sources">
                            <div class="sources-label">Quellen:</div>
                            <xsl:for-each select="tei:noteGrp/tei:note[@target]">
                                <div class="source-item">
                                    <a class="source-link">
                                        <xsl:attribute name="href">
                                            <xsl:choose>
                                                <xsl:when test="contains(@target, 'Augustini')">document_Abraham-Augustini_feuriges_Hertz.html</xsl:when>
                                                <xsl:when test="contains(@target, 'Loesch')">document_Abraham-Loesch_Wienn.html</xsl:when>
                                                <xsl:when test="contains(@target, 'Mercks')">document_Abraham-Mercks_Wien.html</xsl:when>
                                                <xsl:when test="contains(@target, 'Capelle')">document_Abraham-Todten_Capelle.html</xsl:when>
                                                <xsl:when test="contains(@target, 'Bruderschaft')">document_Abraham-Todten_Bruderschaft.html</xsl:when>
                                                <xsl:otherwise>#</xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:attribute>
                                        <span class="source-name">
                                            <xsl:choose>
                                                <xsl:when test="contains(@target, 'Augustini')">Augustini feuriges Hertz</xsl:when>
                                                <xsl:when test="contains(@target, 'Loesch')">Loesch Wienn</xsl:when>
                                                <xsl:when test="contains(@target, 'Mercks')">Mercks Wien</xsl:when>
                                                <xsl:when test="contains(@target, 'Capelle')">Todten Capelle</xsl:when>
                                                <xsl:when test="contains(@target, 'Bruderschaft')">Todten Bruderschaft</xsl:when>
                                                <xsl:otherwise><xsl:value-of select="@target"/></xsl:otherwise>
                                            </xsl:choose>
                                        </span>
                                        <span class="source-count"><xsl:value-of select="@n"/></span>
                                    </a>
                                </div>
                            </xsl:for-each>
                        </div>
                    </xsl:if>
                </div>
            </xsl:for-each>
        </div>

        <div class="no-results hidden" id="noResults">
            Keine Orte gefunden, die den Suchkriterien entsprechen.
        </div>
    </div>

    <script>
        const searchBox = document.getElementById('searchBox');
        const sortSelect = document.getElementById('sortSelect');
        const filterSelect = document.getElementById('filterSelect');
        const typeFilterSelect = document.getElementById('typeFilterSelect');
        const placeGrid = document.getElementById('placeGrid');
        const noResults = document.getElementById('noResults');
        const visiblePlacesCount = document.getElementById('visiblePlaces');

        let allCards = Array.from(document.querySelectorAll('.place-card'));

        function updateVisibleCount() {
            const visibleCards = allCards.filter(card =&gt; !card.classList.contains('hidden'));
            visiblePlacesCount.textContent = visibleCards.length;

            if (visibleCards.length === 0) {
                noResults.classList.remove('hidden');
                placeGrid.style.display = 'none';
            } else {
                noResults.classList.add('hidden');
                placeGrid.style.display = 'grid';
            }
        }

        function filterAndSort() {
            const searchTerm = searchBox.value.toLowerCase().trim();
            const selectedSource = filterSelect.value;
            const selectedType = typeFilterSelect.value;
            const sortBy = sortSelect.value;

            // Filter cards
            allCards.forEach(card =&gt; {
                const name = card.dataset.name;
                const variations = Array.from(card.querySelectorAll('.variation-tag'))
                    .map(tag =&gt; tag.textContent.toLowerCase());
                const sources = card.dataset.sources;
                const type = card.dataset.type;

                const matchesSearch = !searchTerm ||
                    name.includes(searchTerm) ||
                    variations.some(v =&gt; v.includes(searchTerm));

                const matchesSource = selectedSource === 'all' ||
                    sources.includes(selectedSource);

                const matchesType = selectedType === 'all' ||
                    type === selectedType;

                if (matchesSearch &amp;&amp; matchesSource &amp;&amp; matchesType) {
                    card.classList.remove('hidden');
                } else {
                    card.classList.add('hidden');
                }
            });

            // Sort visible cards
            const visibleCards = allCards.filter(card =&gt; !card.classList.contains('hidden'));

            visibleCards.sort((a, b) =&gt; {
                switch(sortBy) {
                    case 'name':
                        return a.dataset.name.localeCompare(b.dataset.name);
                    case 'mentions-desc':
                        return parseInt(b.dataset.mentions) - parseInt(a.dataset.mentions);
                    case 'mentions-asc':
                        return parseInt(a.dataset.mentions) - parseInt(b.dataset.mentions);
                    case 'type':
                        const typeA = a.dataset.type || 'zzz';
                        const typeB = b.dataset.type || 'zzz';
                        return typeA.localeCompare(typeB);
                    default:
                        return 0;
                }
            });

            // Reorder in DOM
            visibleCards.forEach(card =&gt; {
                placeGrid.appendChild(card);
            });

            updateVisibleCount();
        }

        searchBox.addEventListener('input', filterAndSort);
        sortSelect.addEventListener('change', filterAndSort);
        filterSelect.addEventListener('change', filterAndSort);
        typeFilterSelect.addEventListener('change', filterAndSort);

        // Initialize
        filterAndSort();
    </script>
</body>
</html>
</xsl:template>

</xsl:stylesheet>