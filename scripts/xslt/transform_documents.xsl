<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                exclude-result-prefixes="tei xi">

<xsl:output method="html" encoding="UTF-8" indent="yes" doctype-public="-//W3C//DTD HTML 4.01//EN"/>

<xsl:template match="/">
<html lang="de">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Dokumente - Austrian Baroque Corpus</title>
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
                <a href="places_register.html" class="nav-link">
                    <span class="nav-icon">🗺️</span>
                    Register der Orte
                </a>
                <a href="taxonomy.html" class="nav-link">
                    <span class="nav-icon">📚</span>
                    Taxonomie
                </a>
                <a href="documents.html" class="nav-link active">
                    <span class="nav-icon">📖</span>
                    Dokumente
                </a>
            </div>
        </nav>

        <header>
            <h1 class="header-title">Annotierte Dokumente</h1>
            <div class="header-subtitle"><xsl:value-of select="//tei:title"/></div>
            <div class="credits">
                Herausgegeben von:
                <xsl:for-each select="//tei:respStmt[tei:resp='herausgegeben von']/tei:name/tei:name">
                    <xsl:value-of select="."/>
                    <xsl:if test="position() != last()">, </xsl:if>
                </xsl:for-each>
            </div>
        </header>

        <div class="stats">
            <div class="stat-item">
                <div class="stat-number">5</div>
                <div class="stat-label">Dokumente</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">~590</div>
                <div class="stat-label">Seiten</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">~90,000</div>
                <div class="stat-label">Tokens</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">1693-1700</div>
                <div class="stat-label">Zeitraum</div>
            </div>
        </div>

        <div class="documents-container">
            <div class="documents-grid">
                <div class="document-card" data-document="Abraham-Augustini_feuriges_Hertz">
                    <div class="document-header">
                        <h3 class="document-title">Augustini Feuriges Hertz</h3>
                        <span class="document-year">1693</span>
                    </div>
                    <div class="document-author">Abraham à Sancta Clara</div>
                    <div class="document-description">
                        Ein kleiner Haußrath etliche Sententz auß den Schrifften vnsers Heil. Vatters.
                        Zu Trost den verstorbenen Christ-Glaubigen
                    </div>
                    <div class="document-metadata">
                        <div class="metadata-item">
                            <span class="metadata-label">Ort:</span>
                            <span class="metadata-value">Salzburg</span>
                        </div>
                        <div class="metadata-item">
                            <span class="metadata-label">Drucker:</span>
                            <span class="metadata-value">Melchior Haan</span>
                        </div>
                        <div class="metadata-item">
                            <span class="metadata-label">Seiten:</span>
                            <span class="metadata-value">112</span>
                        </div>
                        <div class="metadata-item">
                            <span class="metadata-label">Tokens:</span>
                            <span class="metadata-value">17,273</span>
                        </div>
                        <div class="metadata-item">
                            <span class="metadata-label">Typ:</span>
                            <span class="metadata-value">Erbauungsliteratur</span>
                        </div>
                    </div>
                    <div class="document-actions">
                        <a href="document_Abraham-Augustini_feuriges_Hertz.html" class="btn btn-primary">Dokument lesen</a>
                        <button class="btn btn-secondary">Metadaten</button>
                    </div>
                </div>

                <div class="document-card" data-document="Abraham-Loesch_Wienn">
                    <div class="document-header">
                        <h3 class="document-title">Lösch Wien!</h3>
                        <span class="document-year">1680</span>
                    </div>
                    <div class="document-author">Abraham à Sancta Clara</div>
                    <div class="document-description">
                        Satirische Gesellschaftskritik und Sittengemälde der Stadt Wien
                    </div>
                    <div class="document-metadata">
                        <div class="metadata-item">
                            <span class="metadata-label">Ort:</span>
                            <span class="metadata-value">Wien</span>
                        </div>
                        <div class="metadata-item">
                            <span class="metadata-label">Seiten:</span>
                            <span class="metadata-value">~150</span>
                        </div>
                        <div class="metadata-item">
                            <span class="metadata-label">Tokens:</span>
                            <span class="metadata-value">~22,000</span>
                        </div>
                        <div class="metadata-item">
                            <span class="metadata-label">Typ:</span>
                            <span class="metadata-value">Satire</span>
                        </div>
                    </div>
                    <div class="document-actions">
                        <a href="document_Abraham-Loesch_Wienn.html" class="btn btn-primary">Dokument lesen</a>
                        <button class="btn btn-secondary">Metadaten</button>
                    </div>
                </div>

                <div class="document-card" data-document="Abraham-Mercks_Wien">
                    <div class="document-header">
                        <h3 class="document-title">Mercks Wien</h3>
                        <span class="document-year">1680</span>
                    </div>
                    <div class="document-author">Abraham à Sancta Clara</div>
                    <div class="document-description">
                        Moralische Belehrungen und Ermahnungen an die Wiener Bürgerschaft
                    </div>
                    <div class="document-metadata">
                        <div class="metadata-item">
                            <span class="metadata-label">Ort:</span>
                            <span class="metadata-value">Wien</span>
                        </div>
                        <div class="metadata-item">
                            <span class="metadata-label">Seiten:</span>
                            <span class="metadata-value">~350</span>
                        </div>
                        <div class="metadata-item">
                            <span class="metadata-label">Tokens:</span>
                            <span class="metadata-value">~45,000</span>
                        </div>
                        <div class="metadata-item">
                            <span class="metadata-label">Typ:</span>
                            <span class="metadata-value">Moralschrift</span>
                        </div>
                    </div>
                    <div class="document-actions">
                        <a href="document_Abraham-Mercks_Wien.html" class="btn btn-primary">Dokument lesen</a>
                        <button class="btn btn-secondary">Metadaten</button>
                    </div>
                </div>

                <div class="document-card" data-document="Abraham-Todten_Bruderschaft">
                    <div class="document-header">
                        <h3 class="document-title">Todten Bruderschaft</h3>
                        <span class="document-year">1700</span>
                    </div>
                    <div class="document-author">Abraham à Sancta Clara</div>
                    <div class="document-description">
                        Religiöse Betrachtungen über Tod und Sterblichkeit
                    </div>
                    <div class="document-metadata">
                        <div class="metadata-item">
                            <span class="metadata-label">Seiten:</span>
                            <span class="metadata-value">~100</span>
                        </div>
                        <div class="metadata-item">
                            <span class="metadata-label">Tokens:</span>
                            <span class="metadata-value">~12,000</span>
                        </div>
                        <div class="metadata-item">
                            <span class="metadata-label">Typ:</span>
                            <span class="metadata-value">Religiöse Literatur</span>
                        </div>
                    </div>
                    <div class="document-actions">
                        <a href="document_Abraham-Todten_Bruderschaft.html" class="btn btn-primary">Dokument lesen</a>
                        <button class="btn btn-secondary">Metadaten</button>
                    </div>
                </div>

                <div class="document-card" data-document="Abraham-Todten_Capelle">
                    <div class="document-header">
                        <h3 class="document-title">Todten Capelle</h3>
                        <span class="document-year">1700</span>
                    </div>
                    <div class="document-author">Abraham à Sancta Clara</div>
                    <div class="document-description">
                        Fortsetzung der religiösen Betrachtungen mit Schwerpunkt auf Totengedenken
                    </div>
                    <div class="document-metadata">
                        <div class="metadata-item">
                            <span class="metadata-label">Seiten:</span>
                            <span class="metadata-value">~200</span>
                        </div>
                        <div class="metadata-item">
                            <span class="metadata-label">Tokens:</span>
                            <span class="metadata-value">~25,000</span>
                        </div>
                        <div class="metadata-item">
                            <span class="metadata-label">Typ:</span>
                            <span class="metadata-value">Religiöse Literatur</span>
                        </div>
                    </div>
                    <div class="document-actions">
                        <a href="document_Abraham-Todten_Capelle.html" class="btn btn-primary">Dokument lesen</a>
                        <button class="btn btn-secondary">Metadaten</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="document-features">
            <h2>Dokumentfeatures</h2>
            <div class="features-grid">
                <div class="feature-card">
                    <h3>🏷️ Linguistische Annotation</h3>
                    <p>Vollständige POS-Tagging und Lemmatisierung nach Stuttgart-Tübingen-TagSet</p>
                </div>
                <div class="feature-card">
                    <h3>👤 Personennamen</h3>
                    <p>Identifizierte und verlinkte historische und biblische Personen</p>
                </div>
                <div class="feature-card">
                    <h3>🗺️ Ortsnamen</h3>
                    <p>Geographische Referenzen mit Koordinaten und Klassifizierung</p>
                </div>
                <div class="feature-card">
                    <h3>📄 Seitenfacsimiles</h3>
                    <p>Verlinkung zu digitalisierten Originalseiten</p>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Add metadata toggle functionality
        document.querySelectorAll('.btn-secondary').forEach(button => {
            button.addEventListener('click', function() {
                const card = this.closest('.document-card');
                const metadata = card.querySelector('.document-metadata');

                if (metadata.style.display === 'none' || !metadata.style.display) {
                    metadata.style.display = 'block';
                    this.textContent = 'Metadaten ausblenden';
                } else {
                    metadata.style.display = 'none';
                    this.textContent = 'Metadaten';
                }
            });
        });

        // Initialize metadata as hidden
        document.querySelectorAll('.document-metadata').forEach(metadata => {
            metadata.style.display = 'none';
        });
    </script>
</body>
</html>
</xsl:template>

</xsl:stylesheet>