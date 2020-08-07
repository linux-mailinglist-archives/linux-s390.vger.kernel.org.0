Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CC623F0FF
	for <lists+linux-s390@lfdr.de>; Fri,  7 Aug 2020 18:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgHGQW1 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 7 Aug 2020 12:22:27 -0400
Received: from mail-eopbgr140057.outbound.protection.outlook.com ([40.107.14.57]:4231
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726929AbgHGQWI (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 7 Aug 2020 12:22:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uj+bl0hWv38k+Ko7q3PtXnFHFlTM+6Pi/3rGdH3EgRnU7mWYcQ4xwhxZ7idaJUoUntO8kQet4j8LnqF1YnuudvP1pYxm04xHFpvwhByXeuaMi6MvXcDLU+YjI1QycwHHGZ0eSp/uds0WZYbl2dsvZcvuajItrIAhZrTXwOPu+Vcr/QBA0h3ATiG2ywJOtesBWPMdSx4gHaUkMcp1mbAncpFB9kFqjtFFP6fzIOia4y4EnFccK9GQpphOJXQnBBvdFJtcrz9yikg3AjgD8uDiHBFWg7cCyqoKaTqZ9ZoLIV/0bEECKniy8PCDPEZR9SSunTUzA9hXl44exiN2mXTGNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrZKNq9DZSJg/8lM9Akg9mQ7matGo6hu9ue2IJwmlwg=;
 b=KAiNYwoOf4OQM0giUwHEgjsIKSFi7775UWb6JGQMTWtSHZqc9pg0wzxm7o80qrX9Hj5XV39i+waC2++YeQnA6OPbbWeFcZs3KmEOjvtxWOcIWQrEdTWVB4ufjaJkP+Kyn+COugN871nQYRMi1WuYpN4Am9T5D3WNaAaVch2yevq4WICn9vnMspPPVJGtW/C0G+6/JsZW8O1l0Pr3RKz5xOFJ0hPLB7MP33cyEnn8hCdYs6w7MZvE9nuLncnPpSHz/wWOYhsTw/eP0vyOhFQALWJRzo2Dz/DnTh/8wgxoKHn6CeJSOw1VL0SKncmq6eAum5SwXHB1QrL8zJI/tzLLCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrZKNq9DZSJg/8lM9Akg9mQ7matGo6hu9ue2IJwmlwg=;
 b=csn46IjWEujcEbNld5nMqlkVNJ1oRIdmHT1Pcu1mdzEUkLY48jA5vQjZS8QNNzJlbkYPjCgK3NjVk2bBEa8GAknHwml9BVNxjwyimhmAY3kE1HB+wHRo9Trg1vV3KQ6f0VYoi0ebWIWwftGWnLuSLwrm4CYBVxAu+eOphiZtYiI=
Authentication-Results: gondor.apana.org.au; dkim=none (message not signed)
 header.d=none;gondor.apana.org.au; dmarc=none action=none
 header.from=oss.nxp.com;
Received: from VE1PR04MB6608.eurprd04.prod.outlook.com (2603:10a6:803:125::12)
 by VE1PR04MB7359.eurprd04.prod.outlook.com (2603:10a6:800:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Fri, 7 Aug
 2020 16:21:56 +0000
Received: from VE1PR04MB6608.eurprd04.prod.outlook.com
 ([fe80::a856:c104:11c7:258d]) by VE1PR04MB6608.eurprd04.prod.outlook.com
 ([fe80::a856:c104:11c7:258d%6]) with mapi id 15.20.3261.019; Fri, 7 Aug 2020
 16:21:56 +0000
From:   Andrei Botila <andrei.botila@oss.nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@axis.com, Andrei Botila <andrei.botila@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 08/22] crypto: x86/glue_helper - add check for xts input length equal to zero
Date:   Fri,  7 Aug 2020 19:19:56 +0300
Message-Id: <20200807162010.18979-9-andrei.botila@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
References: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0075.eurprd04.prod.outlook.com
 (2603:10a6:208:be::16) To VE1PR04MB6608.eurprd04.prod.outlook.com
 (2603:10a6:803:125::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv15007.swis.ro-buh01.nxp.com (83.217.231.2) by AM0PR04CA0075.eurprd04.prod.outlook.com (2603:10a6:208:be::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15 via Frontend Transport; Fri, 7 Aug 2020 16:21:54 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff60be81-d101-48d1-24e0-08d83aee0078
X-MS-TrafficTypeDiagnostic: VE1PR04MB7359:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB7359BD014F5DDB0C9E6661D5B4490@VE1PR04MB7359.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IpXISqCWvOq/6h5skve1p7RYEqqimRYuIlBZJ+qWWMqP6om7+SHLPGPpv/Xlc02yjDGo3Ad8gEdyDR+dFJU6cKG1I8RvS7IwMedZmCfoKqHVpNG0A+Qpzp6MXaeukSUBCKYTOpPegJu0IAFYHDKKwWGXk+50AMFuVnkAIMATh6WbyYS9lR2bVBoesSh78kBMM+RUSB17vuKXnRM9Ds9jTMFsINdbLqyvdAPSpM4IC4VL9JpNOPUcMgQ4c9/bfJ5BInrIO4L0nKLdRLWjDqGMlbMl7LuT9QdJ+GCprfY2UJzYhHgCqqxDfyhOwAMkNI6mtOSWmltpb1p42UEDi6xOBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6608.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(44832011)(66556008)(66476007)(110136005)(7416002)(54906003)(1076003)(6506007)(4326008)(66946007)(83380400001)(8936002)(316002)(26005)(956004)(186003)(16526019)(478600001)(4744005)(86362001)(5660300002)(6512007)(2906002)(8676002)(2616005)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: AwEDIqsj/ePUA4tBWZ3fzM+HhVyebB2vAqoKm2BJkPXmxF5ylcbxTIhap1rU4X1q+P0xnZeWZT1j211lkKC4kmlTuJmT4/SmylprVpDTcsokySyBsFvswsHcGfT4XHNQkVqs9eQdDc/E6punaZk14GxLo1x6wZRYZaF+o5J0lh5rfJ7Imvk8lD/P9Gkgb4QtaMD9TCARXA1XLvHe/ec6MJHjmRCHpErKbU32TX/FVaOJdKzlcfDKxt6h7zQLLzgir9CEt6x6fN14PGqitCTxdzhe2jkI4Cm2epY3x2KT3PHWHJl/6pDSYoq/OzK7sNqOk7BnAWlj68+0LiQDaODK0nga5PeJq59qUmA+WmT5lf27JPT+Yhl5gALMmP/YWB53eVZW0waOB2mmq7vG9w2jl/zA8VUoUoN/JT0p5ucPJNoXKQNWaDVMWzPt43IF8q9zpd6XetG3XTaRYaTCNNudDGzARWxgJ5S3qi6UOU8tZdcX+ZI6d/S8RdxqWqalSHVuEVG1SKJ9IBYVFFedYuv/4l0NI2RiiSPPCCcZHw13kmwIjW0YzqiPkFSv0y64+q/VdO8OB4aD7Vu4N3rGP9jYvceBNmMaznZgt45YGhXs8+qX4EbNqRxBAdIkSGg2iS/lKTeuSDvXqiBm6+QzVuc58w==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff60be81-d101-48d1-24e0-08d83aee0078
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6608.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 16:21:55.9415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsD9cH37+giH3iLqApQdOeVUQIXillRiUWeJTvAfCoYQXlMaNgyNbIXcr3exZWYjhBNfTn61d/3vzpUy28UyVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7359
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Andrei Botila <andrei.botila@nxp.com>

Standardize the way input lengths equal to 0 are handled in all skcipher
algorithms. All the algorithms return 0 for input lengths equal to zero.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Andrei Botila <andrei.botila@nxp.com>
---
 arch/x86/crypto/glue_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/crypto/glue_helper.c b/arch/x86/crypto/glue_helper.c
index d3d91a0abf88..cc5042c72910 100644
--- a/arch/x86/crypto/glue_helper.c
+++ b/arch/x86/crypto/glue_helper.c
@@ -275,6 +275,9 @@ int glue_xts_req_128bit(const struct common_glue_ctx *gctx,
 	unsigned int nbytes, tail;
 	int err;
 
+	if (!req->cryptlen)
+		return 0;
+
 	if (req->cryptlen < XTS_BLOCK_SIZE)
 		return -EINVAL;
 
-- 
2.17.1

