Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC1B7E0473
	for <lists+linux-s390@lfdr.de>; Fri,  3 Nov 2023 15:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjKCOOX (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 3 Nov 2023 10:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjKCOOW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Nov 2023 10:14:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25BA1B9;
        Fri,  3 Nov 2023 07:14:19 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3EB6LO032055;
        Fri, 3 Nov 2023 14:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=PcFcbey4B7DabZl8YWC3SuyKVaKD0jjfqgEgdAgk/94=;
 b=lWf4KAbocSeKH7zwMyP8PtciX+WBmJuiv7bzPJ2f3EMqHEdhuFepSSrizh707K/LpJ47
 xTrxx8SqgNM+JWqg8oDiBwTzvIg1b1z+Da2fRnitJtftG3od7aDNcKuvrHqII9r9Na2c
 RDSx43C67FhsjFUI4v0njAXgEhISQqOewD2hd239CtXUYgMNtG5ZSzQI7H+zyNo8fQrs
 NnoQmmSxCq3cSgLX5gbLE96jDZYCKQTWgqlN7jtjXokKEOKjsCaikxTxtEnJQkYv/iVH
 DvBhl+noA9bTYNSZkfhML8aDzAo2DwKRdq6I9VCjZelO0oxw+FYB1U9Z2zyFVHexH+SY hA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u52700jks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 14:14:19 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A3EBbqO004035;
        Fri, 3 Nov 2023 14:14:18 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u52700jhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 14:14:18 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3DkUEi000614;
        Fri, 3 Nov 2023 14:14:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1cmtpqrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 14:14:17 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A3EEF0e17302064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Nov 2023 14:14:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1181F20043;
        Fri,  3 Nov 2023 14:14:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E42B420040;
        Fri,  3 Nov 2023 14:14:14 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Nov 2023 14:14:14 +0000 (GMT)
Date:   Fri, 3 Nov 2023 14:44:24 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Nico Boehr <nrb@linux.ibm.com>
Cc:     frankja@linux.ibm.com, thuth@redhat.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH v7 3/8] s390x: sie: switch to home space
 mode before entering SIE
Message-ID: <20231103144424.139994a5@p-imbrenda>
In-Reply-To: <20231103092954.238491-4-nrb@linux.ibm.com>
References: <20231103092954.238491-1-nrb@linux.ibm.com>
        <20231103092954.238491-4-nrb@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0DMuTPgGRj27A6CowotpCSlZOh-Iv5fe
X-Proofpoint-ORIG-GUID: 11EG2Oz-Y-aSLDMLMH2u4t1UxLZNr5vy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_13,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

On Fri,  3 Nov 2023 10:29:32 +0100
Nico Boehr <nrb@linux.ibm.com> wrote:

> This is to prepare for running guests without MSO/MSL, which is
> currently not possible.
> 
> We already have code in sie64a to setup a guest primary ASCE before
> entering SIE, so we can in theory switch to the page tables which
> translate gpa to hpa.
> 
> But the host is running in primary space mode already, so changing the
> primary ASCE before entering SIE will also affect the host's code and
> data.
> 
> To make this switch useful, the host should run in a different address
> space mode. Hence, set up and change to home address space mode before
> installing the guest ASCE.
> 
> The home space ASCE is just copied over from the primary space ASCE, so
> no functional change is intended, also for tests that want to use
> MSO/MSL. If a test intends to use a different primary space ASCE, it can
> now just set the guest.asce in the save_area.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  lib/s390x/asm/arch_def.h |  1 +
>  lib/s390x/sie.c          | 26 ++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 5beaf15b57e7..745a33878de5 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -92,6 +92,7 @@ enum address_space {
>  };
>  
>  #define PSW_MASK_DAT			0x0400000000000000UL
> +#define PSW_MASK_HOME			0x0000C00000000000UL
>  #define PSW_MASK_IO			0x0200000000000000UL
>  #define PSW_MASK_EXT			0x0100000000000000UL
>  #define PSW_MASK_KEY			0x00F0000000000000UL
> diff --git a/lib/s390x/sie.c b/lib/s390x/sie.c
> index b44febdeaaac..7f4474555ff7 100644
> --- a/lib/s390x/sie.c
> +++ b/lib/s390x/sie.c
> @@ -52,6 +52,8 @@ void sie_handle_validity(struct vm *vm)
>  
>  void sie(struct vm *vm)
>  {
> +	uint64_t old_cr13;
> +
>  	if (vm->sblk->sdf == 2)
>  		memcpy(vm->sblk->pv_grregs, vm->save_area.guest.grs,
>  		       sizeof(vm->save_area.guest.grs));
> @@ -59,6 +61,24 @@ void sie(struct vm *vm)
>  	/* Reset icptcode so we don't trip over it below */
>  	vm->sblk->icptcode = 0;
>  
> +	/*
> +	 * Set up home address space to match primary space. Instead of running
> +	 * in home space all the time, we switch every time in sie() because:
> +	 * - tests that depend on running in primary space mode don't need to be
> +	 *   touched
> +	 * - it avoids regressions in tests
> +	 * - switching every time makes it easier to extend this in the future,
> +	 *   for example to allow tests to run in whatever space they want
> +	 */
> +	old_cr13 = stctg(13);
> +	lctlg(13, stctg(1));
> +
> +	/* switch to home space so guest tables can be different from host */
> +	psw_mask_set_bits(PSW_MASK_HOME);
> +
> +	/* also handle all interruptions in home space while in SIE */
> +	irq_set_dat_mode(true, AS_HOME);
> +
>  	while (vm->sblk->icptcode == 0) {
>  		sie64a(vm->sblk, &vm->save_area);
>  		sie_handle_validity(vm);
> @@ -66,6 +86,12 @@ void sie(struct vm *vm)
>  	vm->save_area.guest.grs[14] = vm->sblk->gg14;
>  	vm->save_area.guest.grs[15] = vm->sblk->gg15;
>  
> +	irq_set_dat_mode(true, AS_PRIM);
> +	psw_mask_clear_bits(PSW_MASK_HOME);
> +
> +	/* restore the old CR 13 */
> +	lctlg(13, old_cr13);
> +
>  	if (vm->sblk->sdf == 2)
>  		memcpy(vm->save_area.guest.grs, vm->sblk->pv_grregs,
>  		       sizeof(vm->save_area.guest.grs));

