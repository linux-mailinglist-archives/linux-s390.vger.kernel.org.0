Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6301F553D58
	for <lists+linux-s390@lfdr.de>; Tue, 21 Jun 2022 23:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355902AbiFUVPC (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 21 Jun 2022 17:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355464AbiFUVOl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 21 Jun 2022 17:14:41 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7A23BBC7;
        Tue, 21 Jun 2022 14:01:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ef1525KvLIIbHFEXwI/9MPL89SOYsDlSXs7p+QTJe5KOTDOEEENmgkC6JN6xKfd3DoHIYKu2L0QuY1k2d5lSSmf00l0wvuPhBrX2eeHGCwYTT5bAcebFOzAPyo1WvRZQTrjQRkS1bFnKolLUwzTkXq6woBGb1QIFPVmLer+TVpC802XgS5CMXr4cHfoInjXKr1+EQrII30FqkH+WgNpqiXru4m/3NT+6tfYZ7i78Ea1a49RAIt9euLtD3AfNybVXPt5BCwEwsRnlBK7F+OwjDYHugv4aBDN4fNsDc8HsowOgVBQjwF0TKa9v+LXzM4p28W1kGgoqoSyHWA546z3Yog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUIF2uGYWjV8j5sOP5LZIAOG0iYID6apJ5elt83pzd4=;
 b=A7TyVQlOHoNACKhAQhR9Bxc6KFNeqjXz9iuUFMNlWeR83XuC4Y2gcidmQpcWVTlNI/J5Fab0j2jCDgIzEzqaQkHt3SEnFvbIMujRemkTzj/kb4/4pXKg04pGbcUWlJIEdHVVbjxXT3lYpDgHJtMk5xRouvtcLKyIEa1g6BwoNlf2Ylipl+dg3nDOP+zzW/H5qFO1UKDa0oF/sIZ0ehsaQkJnf/0tdQj0MFp1e9xHVcZyp9FZ4TXX97piUTYrnobzWn0Y7ZQQWLUKXlP5wWCzEb5HJ7J99aVlRnlmTbmwWAI2H8HXoIGY5ZNAV4Mnylb7PJpiMbvvIsmuY9d1v6l3KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUIF2uGYWjV8j5sOP5LZIAOG0iYID6apJ5elt83pzd4=;
 b=brHZSc4iipxBnLoq4noQxYIjaD+6h4EGFgb31mFP7l6S/UA7maRJXQEEogFiWGVjWZT6I4y5VQjNShRCmFgZgCu7OcVmmHbdIIpb8EHtkbO/U2q7/1KtJuMt0N6V1xqwSbvPCKsMlPOVoTTqlKcvLlfKGTi5bcfra86RzNQjEVig6kkkEfaTa/bQV/BiAPqsWNrFSAxPMr1Pv+8Q9qONoW5DbVaFwKKCmSbGkevWCGTYnTwmpelkSy8tRgghMRiYB5BYfyAeVYV6NGPVh0va9kgX8eYjPcUDBbogWXIlFexK6+8X1uW2yMmkWb+/oO31uF7gAUHazFm37iCRVoOXwA==
Received: from DS7P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::27) by
 CH2PR12MB4940.namprd12.prod.outlook.com (2603:10b6:610:65::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Tue, 21 Jun 2022 21:01:24 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::2a) by DS7P222CA0015.outlook.office365.com
 (2603:10b6:8:2e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15 via Frontend
 Transport; Tue, 21 Jun 2022 21:01:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5353.14 via Frontend Transport; Tue, 21 Jun 2022 21:01:22 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 21 Jun
 2022 21:01:14 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 21 Jun
 2022 14:01:13 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22 via Frontend
 Transport; Tue, 21 Jun 2022 14:01:10 -0700
Date:   Tue, 21 Jun 2022 14:01:08 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Harald Freudenberger <freude@linux.ibm.com>
CC:     <kwankhede@nvidia.com>, <corbet@lwn.net>, <hca@linux.ibm.com>,
        <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
        <zhenyuw@linux.intel.com>, <zhi.a.wang@intel.com>,
        <jani.nikula@linux.intel.com>, <joonas.lahtinen@linux.intel.com>,
        <rodrigo.vivi@intel.com>, <tvrtko.ursulin@linux.intel.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <farman@linux.ibm.com>,
        <mjrosato@linux.ibm.com>, <pasic@linux.ibm.com>,
        <vneethv@linux.ibm.com>, <oberpar@linux.ibm.com>,
        <akrowiak@linux.ibm.com>, <jjherne@linux.ibm.com>,
        <alex.williamson@redhat.com>, <cohuck@redhat.com>,
        <jgg@nvidia.com>, <kevin.tian@intel.com>, <jchrist@linux.ibm.com>,
        <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <intel-gvt-dev@lists.freedesktop.org>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>
Subject: Re: [RFT][PATCH v1 1/6] vfio/ap: Pass in physical address of ind to
 ap_aqic()
Message-ID: <YrIxlLjXS0GiEpYg@Asurada-Nvidia>
References: <20220616235212.15185-1-nicolinc@nvidia.com>
 <20220616235212.15185-2-nicolinc@nvidia.com>
 <fd564e6270a4bfcd9249559a797365ae@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fd564e6270a4bfcd9249559a797365ae@linux.ibm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75d236fb-eb13-4993-cf5b-08da53c9326e
X-MS-TrafficTypeDiagnostic: CH2PR12MB4940:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB49407990A318F120856014A4ABB39@CH2PR12MB4940.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 04odEqA/RIkDlmpf/vRd/TJwXT4qGDzWPGJ2PtjwpfyQRKZNa7NqGJe5ShktE10UZXbnbIcwAFACJ+gmiQpiYdoqXuuyDeDmSpYUNwThHE9S46RaEMsd9HDbg8QqLaneus2w7QZGkJU+VFQowNSKsjIPSwvSBbPZ3NorDoG0fOqa6XDgZyBgp8yNYhl0VrgmhX2uXMJ6U/CqswgsrIAEk2aJnryF2p7bMwCJc6crAckbWwzS5uvXUewXml1GIyfCebOQQ0+yDsP2Zb1zIOqjddY5yGIgfB+riwmApP3XjeVY6lNt9qqrZ9Jgiu7L7TlU/xMVA251JQk02oHtLqOd0Tf3SjXZ5Z7xtJtWEoYh9rsctSHtmu2JY9xGLVjUmz7aQqtY+p3lq992ZEG7HYDoedczG4r0EvwQxHUqWnv7iDe4oafvGNPbHToid99k3kzq6LlQBIJJTpb/rEdsMtPJhFv8eFOD8O6u6BiR+dBSheUNI9OqrZZJnqSbRh4YYeFd6/sQ6YTCMOY2U9gJSw61NRhPgxjAIf1SwO9C4Qggoo5AMJ3VB09lfQln2xyeDmNODMoGgBZgPARIzdNm06KLGsKHpI3lkmFMjvRqzd3xScz3lNVeaXlIhogoSn6HFO81xE7pbQxqsZQa8TJ2qdrl168phb1Z5ceFur5RgDVBgtSIieOhI11v+rPu+VlFs3l5tk/ZBLAJi/3nBBis5oTyd/eb11kwB9enPp2pWwQRqYsYEgTITglRQPkCBZF5FnzF
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(346002)(46966006)(40470700004)(36840700001)(356005)(81166007)(86362001)(41300700001)(26005)(82740400003)(426003)(478600001)(316002)(54906003)(70206006)(70586007)(6916009)(186003)(9686003)(4744005)(8936002)(53546011)(5660300002)(33716001)(8676002)(7406005)(4326008)(2906002)(55016003)(7416002)(336012)(40480700001)(82310400005)(36860700001)(40460700003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 21:01:22.4751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d236fb-eb13-4993-cf5b-08da53c9326e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4940
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jun 20, 2022 at 12:00:53PM +0200, Harald Freudenberger wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2022-06-17 01:52, Nicolin Chen wrote:
> > The ap_aqic() is called by vfio_ap_irq_enable() where it passes in a
> > virt value that's casted from a physical address "h_nib". Inside the
> > ap_aqic(), it does virt_to_phys() again.
> > 
> > Since ap_aqic() needs a physical address, let's just pass in a pa of
> > ind directly. So change the "ind" to "pa_ind".
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

> Add my Reviewed-By: Harald Freudenberger <freude@linux.ibm.com>

Will do. Thanks!
