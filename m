Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672F65B02E0
	for <lists+linux-s390@lfdr.de>; Wed,  7 Sep 2022 13:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiIGL3L (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 7 Sep 2022 07:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGL3K (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Sep 2022 07:29:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD3AB2CD8;
        Wed,  7 Sep 2022 04:29:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7uEuVVqkpfyo6TDHmJFg3AlcLqHjNQ5rhnp5mUkAGlajS6HntdCYQ8TPYwUMBzty6L91qhuhYMKdt9ckVHmshpV/fWV3SbFCGQEE4i/mf9RVdBOhK7cDla40FIbFtgc3gN2Q87zbI2twrcNSnK1jYTHXXRJ7yudd4kByooU8RBt0gYUY+W1EAY7g/ce4xC/EDHZPwvM3CbtIm8Y7C+edC8dSHw81PSjqQr/QlujFgvz93PqyUiE7VDk7jhRDGF86JRgvq7+WrvgfRkPr04bm8Zk1EAsbB9PexXvm/9uFQXqrUwVwwNaOfap71Gf4fz5UGni0ZRnxgPieGycXoG1wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4epeOFVz8FTdarpUM0YUDywoYxIdQDm+toqeiU9Pgg=;
 b=f12wsv0HQIJl4XjfdbY24EBmXPkKkYeYXqQ8O6hGTBOdfu0slNOZgJqkTovITM9MJIfzpUGFMwcNtr/MhJpcqPk03btSnkPJBQMT1dOzYMpO9M3HoCYlij0yk8HSg99FmbizoSzcjaELi5TC9ElVrYHapE28VuV3QyaglkTOp6kG5x9R041DFFCGObvJt7pbumi92XJdojI2XI8FhisK/d0Dr6/DIr/epNYeNuW1rUNAu75R3HJ4xWeaTPnQIjjD0V8D+6Taxxa0CvMMGK++nRbuES7P6UljRL2N4wfkV1ZAWNukpe1G8GL1jI7c5+vHYlD37Z53ZsGCSYG2k/TYXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4epeOFVz8FTdarpUM0YUDywoYxIdQDm+toqeiU9Pgg=;
 b=L2dTL9nbmJUmmmrJUBEZuCEe4oNDSIe95xXBOic52c1G8XekMB8pSJT4RS6eax9HXTz6BQvwtONNH/HCjcdZmtqx3kkQ8XACwtww9GjpRXWNXlR59L3yycqfjF7EGxII9fZdFm+Jp4hBPKW5BcknEoovlcVzn82HFjkBF/z9JGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CH0PR12MB5124.namprd12.prod.outlook.com (2603:10b6:610:bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 11:29:07 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d058:d925:c09b:de2]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d058:d925:c09b:de2%5]) with mapi id 15.20.5588.010; Wed, 7 Sep 2022
 11:29:07 +0000
Message-ID: <e1d933d1-4772-1357-9cf1-6e5b842508c8@amd.com>
Date:   Wed, 7 Sep 2022 16:58:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] perf: Rewrite core context handling
Content-Language: en-US
To:     peterz@infradead.org
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, ak@linux.intel.com, mark.rutland@arm.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        will@kernel.org, robh@kernel.org, mingo@redhat.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, ravi.bangoria@amd.com
References: <20220829113347.295-1-ravi.bangoria@amd.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20220829113347.295-1-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::17) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89476fed-59c9-453a-8951-08da90c42cf5
X-MS-TrafficTypeDiagnostic: CH0PR12MB5124:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TTB78WDlTpwD4GeK+yRVP9don2HVkkIaENMcDf+rRETYQc6rHrX1Y6kgCl+2Mw3yecICiZ5Ki2d//7/vH0qBAc639gt5tGbB0A5ouZ4kbqPIRqKmqfjRVu4piaHYY3m7HiZh//kQPnTEFNR6FcBaG5dQjR1loOgg/l1Bj65J9NtEkYd/zPzGhsp111UUXJihI5P07YnY9I+pXoAWvTCYFV3U5RGqncr9L277RvwwoPfP/U+IxdJTqRUBBFGozyQ8x7TobIsVU5xo34Sjmod6evk4FdxTn96uqYqO8m6UCIeCvPVfyA1OKfGVqh3YMKywCxXjExjmLEmaaVW9nDQ74BcSl6KuEMZqj33Mf+CMrqeNmmjOpBEJiaDn7BMBDn84L0RnXOAhO3WXf+Zo/c+FCi+EFxr8rNpGIP2H0n2tsQXUidzBw+b7zQ6YiBu2FQ//AZLFQy0i9f0Z8bFXgivJaOh4gOU2Xbvv4NXIsGWl/NlJu200bVvIKHTawZkPjiBDXTq15jc7IHMf5lzVvImtTNHbrgP0xB9yj1jVSBR2od0SHgNTzZeNvp6MBHkVBJB5mrpXii8UeBO3q0OTjdXDZQ4fpW4tMs1KRs78d1amZteShM8h/9A/FFLDnH1JxxNdhtRu2ozozMQqRdgZiREKtTk9C0ZJeVqD35XBnxs/ZccBw3C9Kpiz+onIXouFzK2NDjK+3Amf+w7GvaNk6FZO5+aYgbiWwIhmi/pwQk/DUGbCjzNnnQHqHYu+lvSHA90jkSmpJZnwIKp2wckIh7MoSwUKhhAVXKcagQul2EyOtgwWv13mKQVdOEm2iB3PKXLOuBHzkbHt+moFdSwFE0B+NA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(6512007)(38100700002)(2616005)(186003)(36756003)(31686004)(44832011)(31696002)(4326008)(8676002)(66476007)(6486002)(83380400001)(66556008)(478600001)(86362001)(66946007)(2906002)(6506007)(6916009)(26005)(316002)(7416002)(5660300002)(6666004)(41300700001)(8936002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWhocEFsM2NpV2lTSExPd0VtS29YWXVnYnUrdmY4VDAwUjJOdGF6TWJpVkNj?=
 =?utf-8?B?dE9NUC9yRG5GMk9xekhoVU9kejU1cEk5STlFTm1SVlZZYlpoanhBbUJydXlq?=
 =?utf-8?B?U1o0aUo3NXlMY1FBMURRTlRkekp5Ty8yQTFPNGpGcDhKdGFOSTI1UVRMZUNr?=
 =?utf-8?B?MHdodmpYd2RtaURGZlA1cmI1dkJ3WEJEbjBjWHd5VkUyZUV5STZjZDhNWXIr?=
 =?utf-8?B?V2lYZnhhVFVoUUZ4eEV2bW9JL1Bvai9uVUllUlF4RFd3MmpCeHhnMkRYQUVW?=
 =?utf-8?B?M3BYZDNsQUdTdUc2bzFubG9ScWkvR3lHMXVjaFJRZ01QQ0hYZTRwZktqK1Bw?=
 =?utf-8?B?NjEvSUFVUk83TER4c1U2bHNFMHkrS3hGN2grQjNVN2ZxM3hiTGluNzQxRHI4?=
 =?utf-8?B?YWpFRXlQcjdWWi9vZWNKbmlCMEF4NUVZYTVqamRPVWpadkQ4WHRGcy9FWUll?=
 =?utf-8?B?QzJLWVZQV0FBS0tXd3VoQko4VGc4bzJuWVpTbUEwSUhqWWhFeGFtVHM5Y0Jm?=
 =?utf-8?B?cjQxT3FiMWtydC9WVGIvVFpkeUM0VTkwNFhydmdZSUpSUlhwNjg5emxPcDhi?=
 =?utf-8?B?YWtKNkZKTUZxYWZPeWZha1BQTWQ0d1dyZnlQRnMza0RtSkZBdlVBMlA5U05S?=
 =?utf-8?B?MUJwUmVsaWt6SWFMdFdPMGV3b0FvQXFXVy8vY3VIWTFFbCtZVjc3Wnlzb0Zy?=
 =?utf-8?B?Q1E0N1p1VlhHNFRqOFgvU0xtR2ZUYkVreWc0anZhOVFwNEJBQVZMZmJJUmtX?=
 =?utf-8?B?WVppSldPUm5DYk16cXZLNmVwSjFtcCt1YmE3ZEx3cCt0bS9NZktJS1Fmcy9K?=
 =?utf-8?B?QkJVM2lINkxMZDBnanhmM1E0U3k2UDYwWjZFTTRJZDh2Mkw3Nk5uZGFJcnZY?=
 =?utf-8?B?WXk5Q2YrUDVlbFErcUhsQUord2xVRWpKMXBTa1V3dTlqL2xLdHczMDFScTNr?=
 =?utf-8?B?ZjdPR00rVHVmOHphenZuSWxudHBJYmVkSjV6ZWJRUjVlRXJCZFRZOXdFcWVQ?=
 =?utf-8?B?S2JkUnkyZnNBaWZLbkROaThkenBka3dLUWQyQ1FVWDFFUytOMWJ6VkFXMXJh?=
 =?utf-8?B?eUh4Z2kveTY3Z1hDV2J1YSsxaklUZ1l4Ukg2TVhhTzBLTFdmYmwyUlhwWXBp?=
 =?utf-8?B?KzlUcVFDNlZGUFlOUHVNbElobk1FbFNvWUR2cjA0ODlFbUVVbFllWHc4SmdP?=
 =?utf-8?B?L0UvKy9NYjRzUmIyRXVnYkJsVVV0WEJGWVl0WFgxemNoZGN6MnhPVjVYbGpm?=
 =?utf-8?B?QVhvZWF4VHRya2J5eWRaclBXaE9PU28zVWx1WlhZSklidDBEZC9qKy9tY1dX?=
 =?utf-8?B?UmphQ1dzME9POXNrdEEyKy8weGNIZmsvV0RlcHMvZUxmTmh6UElRN1hlaE5a?=
 =?utf-8?B?T2ZNY25uZEhXN0h3MEIrSFp5V1ZvNmN0M1NwVWhYSm1zbjdRYjViQUZiajFE?=
 =?utf-8?B?MW44TVVGY2FzbHh1VGNGem9PRnovRCtUTDlMc1FxeHZwVDN4dUlkb0lTZlEy?=
 =?utf-8?B?eWR1cVpIVXRvQmdEa3BHMVBqWFlMTW9LdUcvbFRLWmhOQmN0Z1hBRUdOd1Br?=
 =?utf-8?B?VUtueXdBblRGM1hhUS81K3Z0bC9wcmNIVXM5MmJNQUpndHpCemtRaW9KOVJz?=
 =?utf-8?B?YW5pMWUxbGY3ZnNrTmE1V3VnMXlJaFpzV1lWSDVTZkpVMDJjWkpnUnozejNk?=
 =?utf-8?B?MUxzUVhMT2p1ajdoY2N1SFJOaWtTUUxRWDRweERzVENTU2FDMVJpVTM2dURJ?=
 =?utf-8?B?TE14RDVPaFA0cSs0NTFBbGg0UnZvK3c3VmdxLzIwQ2dreC93VjNRUThmSGFI?=
 =?utf-8?B?NkgxV09OK2svMm9SSUozTHdZUnRMUVFvc3VsQ3pFOU1pVk5hUlZ0ZVVqd0NJ?=
 =?utf-8?B?cFVMWmljekFnakE5aGVVakNhQ1huNm5UekoxQ0hOTnJDVnZPSld2NDg5aE1V?=
 =?utf-8?B?UExQMlY1bHVaY0hqbnhhcXB6K2haL2hURlozUUFsK2kxNm13aHk4Mk1zUXc3?=
 =?utf-8?B?a2k4R2Q2alkzNVBzY1ZUcElYekxxSU8zRDdxVVdnTXQ2ckhkd1U2VWZQT3Z4?=
 =?utf-8?B?bG5qV1BGazRscGtvQ3MrUU92bHlwcFhLakNTSzhvVGIzWjY2R2xDbEJmQnFH?=
 =?utf-8?Q?NMSQguppoS2ffePfYR0xLcGE+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89476fed-59c9-453a-8951-08da90c42cf5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 11:29:07.3613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMQRt+CTeI5T2LXlAvNuNSvHTL4GPmcy3jTOcPyBR7HwZUoocRNQGos6vglV51U9EAz61XjXqY4vNOl4wx2poQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5124
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

> -static void
> -ctx_flexible_sched_in(struct perf_event_context *ctx,
> -		      struct perf_cpu_context *cpuctx)
> +/* XXX .busy thingy from Peter's patch */
> +static void ctx_flexible_sched_in(struct perf_event_context *ctx, struct pmu *pmu)

This one turned out to be very easy. Given that, we iterate over each
pmu, we can just return error if we fail to schedule any flexible event.
(It wouldn't be straight forward like this if we needed to implement
pmu=NULL optimization.)

---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e0232e0bb74e..923656af73fe 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3751,6 +3751,7 @@ static int merge_sched_in(struct perf_event *event, void *data)
 			cpc = this_cpu_ptr(event->pmu_ctx->pmu->cpu_pmu_context);
 			perf_mux_hrtimer_restart(cpc);
 			group_update_userpage(event);
+			return -EBUSY;
 		}
 	}
 
@@ -3776,7 +3777,6 @@ static void ctx_pinned_sched_in(struct perf_event_context *ctx, struct pmu *pmu)
 	}
 }
 
-/* XXX .busy thingy from Peter's patch */
 static void ctx_flexible_sched_in(struct perf_event_context *ctx, struct pmu *pmu)
 {
 	struct perf_event_pmu_context *pmu_ctx;
---

Thanks,
Ravi
