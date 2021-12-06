Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18FC46A4B4
	for <lists+linux-s390@lfdr.de>; Mon,  6 Dec 2021 19:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243050AbhLFSit (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 6 Dec 2021 13:38:49 -0500
Received: from mail-dm6nam08hn2221.outbound.protection.outlook.com ([52.100.161.221]:5408
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242707AbhLFSis (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 6 Dec 2021 13:38:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZYnAu2DyowkQS4S3430yzdSEHJ1flpS9JNU96dIC57eDHrlh1XSsXvpQmOqXXyNHwifLh3am8SXoAHmg4VSDhI8r6YtshIkBB1C9HrMFzWi+V3ZMraZyL+XSPHMTaZhV8K5V2Jg5qHW8hlR2BF+ov2SmmAYbMkRthJOalBa7HsFLYAFoTCB823L9BIsxxLL1/twTXnQcwmzGIAa0Mu7Tw+efZdELGv+wpBLt1zBNr7pQQnMOqlS+gsARmDr58Ja7AXS1BsmSOLVlGQX3SdikTXsyCntDRgvUc07n7/1eeEanlXuU9l9+s6WtZAZO2Qfqcciye7HXpRqOaCtkvDbyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTkULZ5UHExQp4+lt+mjKcEqTWLs4cv4821EJcQtSYE=;
 b=JxmYZ6EzzpCulb0zT0OW/G5vkUGDEcT7YDWi7taait1nzcvqr1F8H0LFYVkFpnLhFX2ZnrmsF7+3lFWP4sU8/K0Jju76UTlNq5GeMr/OH/+1DkB7Ele/eTzVo0gWOK5LWi1RARuajYgyG2qiHoSx6ojSrO7DqSC6lRsQx+YwGK7qt3b7DkSEOiIhiUlPm2t/oIcEmaokWVGkMmfcwgCXr+RJFAM9l88JWSWPKj0HbgoiRikxT+gQ9pMWitKAhbhly5+EJQrfzcUO8o2da39tDA4xWEEK+cZLCMLcwD2NhnaynLH4oRWyHQqJ7e6mcS1LTtW9R+5OmXQl4lLdVo2ntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 146.201.107.145) smtp.rcpttodomain=shell.opensde.net
 smtp.mailfrom=msn.com; dmarc=fail (p=none sp=quarantine pct=100) action=none
 header.from=msn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fsu.onmicrosoft.com;
 s=selector2-fsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTkULZ5UHExQp4+lt+mjKcEqTWLs4cv4821EJcQtSYE=;
 b=dqLLDUrRdwShvKSVk2AMHp4JuAAFcCpDG/n/Z5oHKDtFLScwO/nWTYvFSkb7xmPbM6ArO1M8lv3serc7AXqgtFPoYTZHu6J6RaOCNOZWmm2PpfsGasWaMzu2J2CpEi7z8ACQZgZ5pTn6THFZ/f3Wn8wZNMPixrVpXih25T0ReKQ=
Received: from BN6PR2001CA0012.namprd20.prod.outlook.com
 (2603:10b6:404:b4::22) by SJ0P220MB0590.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:305::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 18:35:07 +0000
Received: from BN8NAM04FT027.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::b3) by BN6PR2001CA0012.outlook.office365.com
 (2603:10b6:404:b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend
 Transport; Mon, 6 Dec 2021 18:35:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 146.201.107.145) smtp.mailfrom=msn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=msn.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 msn.com discourages use of 146.201.107.145 as permitted sender)
Received: from mailrelay03.its.fsu.edu (146.201.107.145) by
 BN8NAM04FT027.mail.protection.outlook.com (10.13.161.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.13 via Frontend Transport; Mon, 6 Dec 2021 18:35:07 +0000
Received: from [10.0.0.200] (ani.stat.fsu.edu [128.186.4.119])
        by mailrelay03.its.fsu.edu (Postfix) with ESMTP id F352A9518E;
        Mon,  6 Dec 2021 13:34:31 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re: From Fred!
To:     Recipients <fred128@msn.com>
From:   "Fred Gamba." <fred128@msn.com>
Date:   Mon, 06 Dec 2021 19:33:49 +0100
Reply-To: fred_gamba@yahoo.co.jp
Message-ID: <7d40b34e-c45d-49b8-bce5-6ac54ad02288@BN8NAM04FT027.eop-NAM04.prod.protection.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 044870af-929b-487c-7a3e-08d9b8e720b3
X-MS-TrafficTypeDiagnostic: SJ0P220MB0590:EE_
X-Microsoft-Antispam-PRVS: <SJ0P220MB0590CC20E05A9390E2D91580EB6D9@SJ0P220MB0590.NAMP220.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Forefront-Antispam-Report: CIP:146.201.107.145;CTRY:US;LANG:en;SCL:5;SRV:;IPV:CAL;SFV:SPM;H:mailrelay03.its.fsu.edu;PTR:mailrelay03.its.fsu.edu;CAT:OSPM;SFS:(4636009)(84050400002)(46966006)(40470700001)(7596003)(2906002)(86362001)(356005)(336012)(2860700004)(82202003)(9686003)(40460700001)(8936002)(70586007)(6266002)(508600001)(7116003)(82310400004)(31696002)(5660300002)(70206006)(7416002)(47076005)(26005)(8676002)(6862004)(7366002)(6666004)(83380400001)(7406005)(956004)(786003)(316002)(31686004)(6200100001)(35950700001)(3480700007)(480584002);DIR:OUT;SFP:1501;
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzlJZjVnSHdWSnFEYVFvcnpwYjA1VHRpRlJ4NzdpOWUxVXQvWnEveUFWUVhS?=
 =?utf-8?B?Z3JjZ1dWaitQdytLUDZOaG54MHhpMXM0U0V2NldQVlNlbGxzZHhWT1psSmJy?=
 =?utf-8?B?M3VqRHpNUzdVcHVoMjNCSmNhTXRvT01VMURyWGRBZHBwbm1OR0JzakpBdU1L?=
 =?utf-8?B?dkxPTG1hQVUrUmNyUHA1b1lYbFZRZWNvSXdhVlFiMUtsMmtlSFJEczF6Uysw?=
 =?utf-8?B?TEM3OGlmUGdPTDZ0MjVaeFc3ZFVGMkt3UnN2K3cyU2NkWDZEMmJBMVlHMWt0?=
 =?utf-8?B?VlFjQzE4d2M4Q0xSd2JXSFYzWWhzZnQ3VjZ3OTN0SytINC9LQjZqaWdtWkdK?=
 =?utf-8?B?cW1pdzk3Q2taVXlmVmhVa2MrQm9Zcm8xUzhxYzR4REVJQzJqZWFESHRiYWJB?=
 =?utf-8?B?dlZBTkhXSnBqbFpQT3F1elE1Z2paMUFWTFFTdlhQdCtTNFNjcUxmM0tUQ3NV?=
 =?utf-8?B?T2lmTndDY2plNitQNlFsclo4dWE5WFhwa3IvNDhiUmVNVU9HbEJ4Z05WUytn?=
 =?utf-8?B?SEFDMEVscnlQNDRZL3hkS0UxVE1lcmhQQTNvTnR1SGkrRXhFdEJtUFM3QWUx?=
 =?utf-8?B?K1c3VUVUTnVQYlh6VEFkcGNQQ2RXcFB1QnhEOXdGb3ZwY3B5U2NtUzNDdnFt?=
 =?utf-8?B?VFFoMElMSHVxUUxyTGJacDhuVGUraklkVDc3cGFiVVE4TkNyQ0VIeGNyRkVM?=
 =?utf-8?B?QTMvOGM3SG5Vb1E3cmFSVjBQS0x0dzY0SW9uTGoyeVFUbi9QK2JFYm5Oci9n?=
 =?utf-8?B?a0J6TGV4c040VEdGdU54SGhjVzFISW5uQVIzaXNySXlwaUdtL3krdnJLOEVz?=
 =?utf-8?B?UWNnZ21Od0lyUklKZzBIekJGVzJkanp1NzJjTDNsWE5lM3VLUTJEMWhSK3Nq?=
 =?utf-8?B?RGFJTU05cDQydm5vUEpQTzQ4NXpJaUN0eDhWUlBiYW5vRnVtODMvWDZZMFd3?=
 =?utf-8?B?c3Bsc0tPdHpEeFRHT2dnNVR5Rjhsa2xCaDdTM0dLOUY1dEQ2am8xN0JlUytw?=
 =?utf-8?B?NS9tZXFjRWl3LzQvN2VGYkZrN3dRdzNSVlNpbzFYK2RWSVE2NDBNUy94eUJh?=
 =?utf-8?B?aHUvK2VaSzhpZHlWREtaN0d4Q1MzOThpVTdzc2NvTEl3M0pIUW1ZWE5DQjVl?=
 =?utf-8?B?aEpBcXlMZWNTOXNQYkFhSlRQNGQ5NVc2b1lGVzFqZ2hVdnFyTWRmZkJSeTVF?=
 =?utf-8?B?YnFYcmFGZVhxcHdMNmg1YWdEMVNLQVZpa1BQZHNwbkl6dk8xVFcvUnM1bEhp?=
 =?utf-8?B?cjlIcFJuWVpOTnRERnJvRnpTRldtUTFBdlJKaE11K1ZRM3FwaXNmbUZpTTAy?=
 =?utf-8?B?bHU3QnNXRitOTHZVMkowQkRKZk54QUJFWEcvV0JwQlQ3QWltbDlBcEx2enpB?=
 =?utf-8?B?bkRNQTNDVXNOKy9XdjErODNJSzRhU05WTjI3MEp6eGZoeHdkQlpuL093TTdy?=
 =?utf-8?Q?/Q1cOTOu?=
X-OriginatorOrg: fsu.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 18:35:07.4287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 044870af-929b-487c-7a3e-08d9b8e720b3
X-MS-Exchange-CrossTenant-Id: a36450eb-db06-42a7-8d1b-026719f701e3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a36450eb-db06-42a7-8d1b-026719f701e3;Ip=[146.201.107.145];Helo=[mailrelay03.its.fsu.edu]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT027.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0P220MB0590
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello,

I decided to write you this proposal in good faith, believing that you will=
 not betray me. I have been in search of someone with the same last name of=
 our late customer and close friend of mine (Mr. Richard), heence I contact=
ed you Because both of you bear the same surname and coincidentally from th=
e same country, and I was pushed to contact you and see how best we can ass=
ist each other. Meanwhile I am Mr. Fred Gamba, a reputable banker here in A=
ccra Ghana.

On the 15 January 2009, the young millionaire (Mr. Richard) a citizen of yo=
ur country and Crude Oil dealer made a fixed deposit with my bank for 60 ca=
lendar months, valued at US $ 6,500,000.00 (Six Million, Five Hundred Thous=
and US Dollars) and The mature date for this deposit contract was on 15th o=
f January, 2015. But sadly he was among the death victims in the 03 March 2=
011, Earthquake disaster in Japan that killed over 20,000 people including =
him. Because he was in Japan on a business trip and that was how he met his=
 end.

My bank management is yet to know about his death, but I knew about it beca=
use he was my friend and I am his Account Relationship Officer, and he did =
not mention any Next of Kin / Heir when the account was opened, because he =
was not married and no children. Last week my Bank Management reminded me a=
gain requested that Mr. Richard should give instructions on what to do abou=
t his funds, if to renew the contract or not.

I know this will happen and that is why I have been looking for a means to =
handle the situation, because if my Bank Directors happens to know that he =
is dead and do not have any Heir, they will take the funds for their person=
al use, That is why I am seeking your co-operation to present you as the Ne=
xt of Kin / Heir to the account, since you bear same last name with the dec=
eased customer.

There is no risk involved; the transaction will be executed under a legitim=
ate arrangement that will protect you from any breach of law okay. So It's =
better that we claim the money, than allowing the Bank Directors to take it=
, they are rich already. I am not a greedy person, so I am suggesting we sh=
are the funds in this ratio, 50% 50, ie equal.

Let me know your mind on this and please do treat this information highly c=
onfidential.

I will review further information to you as soon as I receive your
positive response.

Have a nice day and I anticipating your communication.

With Regards,
Fred Gamba.
