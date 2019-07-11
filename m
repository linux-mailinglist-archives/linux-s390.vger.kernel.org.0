Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 165B96622B
	for <lists+linux-s390@lfdr.de>; Fri, 12 Jul 2019 01:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbfGKX0Q (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 11 Jul 2019 19:26:16 -0400
Received: from mail-eopbgr740122.outbound.protection.outlook.com ([40.107.74.122]:20938
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727956AbfGKX0Q (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 11 Jul 2019 19:26:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H72uxq60xQjxq2IdSa5bZbSJObgIQOUna8KyrK3a2PMGAZ1lJLmU32kEKLmRvjZ6BcCA4oK7BV949voioNbrWkvbb7TDmnFfeWV3y8QHqafn5x5rLSFwxenyayi55+s4Te+Ul7VhLeWvTt4CV79H99YDEJiCASYID8znWvw9MwUHhw5sxU0F8CjmNVLTBingo63tqf+3WWJ+38i0EXzjZMIEZEk9nouzGVGVzDTwH9F6nRRj4/8QM+fldBJZoNJ9bN+fGY5stdFreNgu5g4eXjHoCJ1OWQLTtwl+FMBIW/KViaigVPirxx5k54tXrtrDIaSW1pMpVQ4ARsSfQT7lJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luzPCoCoJwdLxcuGKQo5XegVYEzzGjOGacJDRS1Q7fg=;
 b=IsdKFaKC5ln+tGjwimrm2xPSfegyQBUmjFsQHuhSImRzU+HgpJBzsqAAc8AzK05yVtPKPQcTKkwvOCja3uX25sVUnrw4okt5TonONdPyC67P0Rh99vBfDvDVJkUKe2jtCAYinmlJxuCw0TWFBUckMSmLrQCKqErsc//1YDRhLo3E7X5+dWmfEHv1Ghp9YfPZrA/FvJr/9osjhhPhtiltv5/1sxoGDWILhMtidlMfqW8SYDiO0xfi9JKvMl5JpVasr2DfSeoxmKUBYNw3CSWc/ZvOK5j7zAAI/kh68m8+1HS2MkUpVjfYzd9MvrKDFngmXHWNcr31jnmEVUhk7yxwDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=os.amperecomputing.com;dmarc=pass action=none
 header.from=os.amperecomputing.com;dkim=pass
 header.d=os.amperecomputing.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luzPCoCoJwdLxcuGKQo5XegVYEzzGjOGacJDRS1Q7fg=;
 b=dn+tbk6FURLivSfjybA3IHPzwg3paVCzK+/WVoZI8ByeAWsuyNB5l/lO3aVA+VTxTpem8yUY/WaHp0DyUggUanfFd5WRz2Vxm3lXyjPXUlD/a6NECF/JJKpH8n/GgSo7CTdCLCxj5cVr+BKKtaOA4Q/iQVW30E3cB5voDv62JVE=
Received: from BYAPR01MB4085.prod.exchangelabs.com (52.135.237.22) by
 BYAPR01MB5557.prod.exchangelabs.com (20.179.88.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Thu, 11 Jul 2019 23:25:54 +0000
Received: from BYAPR01MB4085.prod.exchangelabs.com
 ([fe80::9dbb:1b4c:bace:ef80]) by BYAPR01MB4085.prod.exchangelabs.com
 ([fe80::9dbb:1b4c:bace:ef80%7]) with mapi id 15.20.2052.020; Thu, 11 Jul 2019
 23:25:54 +0000
From:   Hoan Tran OS <hoan@os.amperecomputing.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "David S . Miller" <davem@davemloft.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
CC:     "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Open Source Submission <patches@amperecomputing.com>,
        Hoan Tran OS <hoan@os.amperecomputing.com>
Subject: [PATCH v2 4/5] sparc: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
Thread-Topic: [PATCH v2 4/5] sparc: Kconfig: Remove
 CONFIG_NODES_SPAN_OTHER_NODES
Thread-Index: AQHVOD/8WEih1KGuo0+kPmIjHrQcVQ==
Date:   Thu, 11 Jul 2019 23:25:54 +0000
Message-ID: <1562887528-5896-5-git-send-email-Hoan@os.amperecomputing.com>
References: <1562887528-5896-1-git-send-email-Hoan@os.amperecomputing.com>
In-Reply-To: <1562887528-5896-1-git-send-email-Hoan@os.amperecomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR19CA0045.namprd19.prod.outlook.com
 (2603:10b6:903:103::31) To BYAPR01MB4085.prod.exchangelabs.com
 (2603:10b6:a03:56::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hoan@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [4.28.12.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77216daf-75a9-4c89-f972-08d706571e5e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR01MB5557;
x-ms-traffictypediagnostic: BYAPR01MB5557:
x-microsoft-antispam-prvs: <BYAPR01MB555745D520353EADC00AB9FEF1F30@BYAPR01MB5557.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(39840400004)(136003)(396003)(366004)(189003)(199004)(52116002)(66476007)(66556008)(66946007)(64756008)(66446008)(14454004)(5660300002)(1511001)(6506007)(386003)(71190400001)(71200400001)(6436002)(53936002)(66066001)(4744005)(102836004)(25786009)(68736007)(6512007)(86362001)(3846002)(11346002)(2616005)(186003)(81166006)(26005)(2906002)(446003)(478600001)(4326008)(76176011)(6486002)(7736002)(305945005)(54906003)(8936002)(110136005)(7416002)(6116002)(99286004)(476003)(316002)(8676002)(107886003)(81156014)(486006)(256004)(50226002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR01MB5557;H:BYAPR01MB4085.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0nwmbw+iMbUDY/4qjNSaddHS50JkaRduORIoyilAFYbU08UhPt0cW0WCLUK9BK3fRcrt+svD6MI5ooWlKMuuMtAc13hvSW8UGY7tVikY4IQNXtUFtWG0/HsV/ckhfo1pipvvd5s3pVUZbVq9uPZXT5R2hDyK3uqdB1+F2xwKKOO6xWP5xKhhiOLEwFeaTDVHF6MCtLR3jDzu0bVPC1vYzsecWDX68xTaFJtaDs5TCtQB0AVSCqI18bkaZGbEndNxBCs7dCu1QjqKmvIqPTYy3apuQyEbCjDQ5ZjiNXLHsR8qWS0sqTg+ZEh9ZTR2YyKFAjsRh5k+5xnVxBH96pI81XAUkJV0ZhuI6CGCfT8HtgEOyzj3Fzjew01+1PmcbO+KSn9DgLNSBfY7rJX41s4TXm7D93y3yO6lhVq1Gjuhdbs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77216daf-75a9-4c89-f972-08d706571e5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 23:25:54.1124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hoan@os.amperecomputing.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5557
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Remove CONFIG_NODES_SPAN_OTHER_NODES as it's enabled
by default with NUMA.

Signed-off-by: Hoan Tran <Hoan@os.amperecomputing.com>
---
 arch/sparc/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 26ab6f5..13449ea 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -291,15 +291,6 @@ config NODES_SHIFT
 	  Specify the maximum number of NUMA Nodes available on the target
 	  system.  Increases memory reserved to accommodate various tables.
=20
-# Some NUMA nodes have memory ranges that span
-# other nodes.  Even though a pfn is valid and
-# between a node's start and end pfns, it may not
-# reside on that node.  See memmap_init_zone()
-# for details.
-config NODES_SPAN_OTHER_NODES
-	def_bool y
-	depends on NEED_MULTIPLE_NODES
-
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y if SPARC64
=20
--=20
2.7.4

