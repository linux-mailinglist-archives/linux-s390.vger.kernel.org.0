Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8237E0472
	for <lists+linux-s390@lfdr.de>; Fri,  3 Nov 2023 15:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjKCOOU (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 3 Nov 2023 10:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjKCOOU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Nov 2023 10:14:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E701BC;
        Fri,  3 Nov 2023 07:14:17 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3ECUBg020733;
        Fri, 3 Nov 2023 14:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=R158DBa2XarUU+nGSqcwzE8CB6KXEGH4rLNDjZjKD5k=;
 b=sf966Sfy84xiT0XKhZhVIreKsDa/8E2hO9j1KmFxU3S8WFxMf/HxYZrCDBsD8eYYdzrk
 mAypovsQ0+6zstrktt9GKQAeBRU+CWQlx93hS2MqPztUq2/UhQrAJzZo7n4uStE/lSpz
 RfsHLhKHJR92kKzWgwM5D8RVjnVEs00bthgl3oqESt/AsUL+agcMnVFtQPBH1ZHH7fCK
 9NTh1epq6+d6HfywmQfszqS36L6P+F6v9pe+SwHIW2kUEDyfEmUAtm1RtiPY+IHc857c
 2vz+laT1YWunjVO9g88ZrLTo3AdL0yeDm/OlA8H98SxkByNKKtY8/B+HIAGAhS8LAwmF nA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u52dxr2er-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 14:14:17 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A3ECcCx021352;
        Fri, 3 Nov 2023 14:14:16 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u52dxr2e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 14:14:16 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3BoSlg007685;
        Fri, 3 Nov 2023 14:14:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1dmp6e9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 14:14:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A3EECpd45678860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Nov 2023 14:14:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84FC52004E;
        Fri,  3 Nov 2023 14:14:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6327820043;
        Fri,  3 Nov 2023 14:14:12 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Nov 2023 14:14:12 +0000 (GMT)
Date:   Fri, 3 Nov 2023 15:12:56 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Nico Boehr <nrb@linux.ibm.com>
Cc:     frankja@linux.ibm.com, thuth@redhat.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH v7 7/8] s390x: add a test for SIE without
 MSO/MSL
Message-ID: <20231103151256.43fdb506@p-imbrenda>
In-Reply-To: <20231103092954.238491-8-nrb@linux.ibm.com>
References: <20231103092954.238491-1-nrb@linux.ibm.com>
        <20231103092954.238491-8-nrb@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3e4znfflo178GowVVpd7pACxOxDxABG1
X-Proofpoint-GUID: WGxpxw0LeBinr-_6ss912k0Ym8U-hZC-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_13,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030120
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri,  3 Nov 2023 10:29:36 +0100
Nico Boehr <nrb@linux.ibm.com> wrote:

> Since we now have the ability to run guests without MSO/MSL, add a test
> to make sure this doesn't break.

[...]

> +	/* the guest will now write to an unmapped address and we check that this causes a segment translation exception */
> +	report_prefix_push("guest write to unmapped");
> +	expect_pgm_int();
> +	sie(&vm);
> +	check_pgm_int_code(PGM_INT_CODE_SEGMENT_TRANSLATION);

can you also check that the faulting address is the one we expect?

> +	report_prefix_pop();
> +}
> +

[...]

> diff --git a/s390x/snippets/c/sie-dat.c b/s390x/snippets/c/sie-dat.c
> new file mode 100644
> index 000000000000..e07136bf7430
> --- /dev/null
> +++ b/s390x/snippets/c/sie-dat.c
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Snippet used by the sie-dat.c test to verify paging without MSO/MSL
> + *
> + * Copyright (c) 2023 IBM Corp
> + *
> + * Authors:
> + *  Nico Boehr <nrb@linux.ibm.com>
> + */
> +#include <libcflat.h>
> +#include <asm-generic/page.h>
> +#include "sie-dat.h"
> +
> +static uint8_t test_page[GUEST_TEST_PAGE_COUNT * PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));

I would call it test_pages

[...]
