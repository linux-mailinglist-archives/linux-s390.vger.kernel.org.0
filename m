Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DC04709A4
	for <lists+linux-s390@lfdr.de>; Fri, 10 Dec 2021 20:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245688AbhLJTHe (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 10 Dec 2021 14:07:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48750 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245414AbhLJTHb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Dec 2021 14:07:31 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAJ3rd0009710;
        Fri, 10 Dec 2021 19:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=dnU6ziVX6lNVXmer2OLxhsF26LT6YN4QKuME1rOHxe8=;
 b=ja+vmNbVMVzni+hKKUb4goFN3aqia3ZXzqLaPLVY2C9Mg3zrSJ2oeJDuu2kn/k00LiX/
 YQUVmhNCtpmUo8eTRpQj6Etbrt00bF7OmU/a50j2MD1ysG+Do3BwoflN6LogbJkdlBaL
 qAu+Yy1S6ej/lRqriSBwcbnlp+mYNdftr80vRTsDFzfIkjtsK3teGLNJCxfO1xxMV0q1
 JK32h31gSeiKGeOMnD5u/l5+/gHyq7f1DbPPPLiqGUEcggLApls1yVJC+VsyIF4QqYpx
 6T31dLF2Em3CiLpbo4umqMOrknR2E7JI5bdL2WE6z2AMpDw7YDdCRsM74CncUitTmjI1 ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cvaep2xym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 19:03:54 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BAJ0Ks7023255;
        Fri, 10 Dec 2021 19:03:54 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cvaep2xvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 19:03:54 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BAIbxck025015;
        Fri, 10 Dec 2021 19:02:14 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma05wdc.us.ibm.com with ESMTP id 3cqyycn2jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 19:02:14 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BAJ2Di833947992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 19:02:13 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83091C607B;
        Fri, 10 Dec 2021 19:02:13 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEE93C6092;
        Fri, 10 Dec 2021 19:02:11 +0000 (GMT)
Received: from farman-thinkpad-t470p (unknown [9.211.80.105])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 10 Dec 2021 19:02:11 +0000 (GMT)
Message-ID: <5ce26bf8c31e79f62db0de996a211afc6c2186d7.camel@linux.ibm.com>
Subject: Re: [PATCH 08/32] s390/pci: stash associated GISA designation
From:   Eric Farman <farman@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        schnelle@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com, freude@linux.ibm.com,
        thuth@redhat.com, pasic@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 10 Dec 2021 14:01:06 -0500
In-Reply-To: <20211207205743.150299-9-mjrosato@linux.ibm.com>
References: <20211207205743.150299-1-mjrosato@linux.ibm.com>
         <20211207205743.150299-9-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IBr9xMKeDyUwtr4iJjefSQozX-EA5NVb
X-Proofpoint-GUID: U64KN5XcEmECHfA-RQzgb3N3W16XFsvd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_06,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112100104
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 2021-12-07 at 15:57 -0500, Matthew Rosato wrote:
> For passthrough devices, we will need to know the GISA designation of
> the
> guest if interpretation facilities are to be used.  Setup to stash
> this in
> the zdev and set a default of 0 (no GISA designation) for now; a
> subsequent
> patch will set a valid GISA designation for passthrough devices.
> Also, extend mpcific routines to specify this stashed designation as
> part
> of the mpcific command.
> 
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>

Reviewed-by: Eric Farman <farman@linux.ibm.com>

> ---
>  arch/s390/include/asm/pci.h     | 1 +
>  arch/s390/include/asm/pci_clp.h | 3 ++-
>  arch/s390/pci/pci.c             | 9 +++++++++
>  arch/s390/pci/pci_clp.c         | 1 +
>  arch/s390/pci/pci_irq.c         | 5 +++++
>  5 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/pci.h
> b/arch/s390/include/asm/pci.h
> index 90824be5ce9a..2474b8d30f2a 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -123,6 +123,7 @@ struct zpci_dev {
>  	enum zpci_state state;
>  	u32		fid;		/* function ID, used by sclp
> */
>  	u32		fh;		/* function handle, used by
> insn's */
> +	u32		gd;		/* GISA designation for
> passthrough */
>  	u16		vfn;		/* virtual function number */
>  	u16		pchid;		/* physical channel ID */
>  	u8		pfgid;		/* function group ID */
> diff --git a/arch/s390/include/asm/pci_clp.h
> b/arch/s390/include/asm/pci_clp.h
> index 1f4b666e85ee..3af8d196da74 100644
> --- a/arch/s390/include/asm/pci_clp.h
> +++ b/arch/s390/include/asm/pci_clp.h
> @@ -173,7 +173,8 @@ struct clp_req_set_pci {
>  	u16 reserved2;
>  	u8 oc;				/* operation controls */
>  	u8 ndas;			/* number of dma spaces */
> -	u64 reserved3;
> +	u32 reserved3;
> +	u32 gd;				/* GISA designation */
>  } __packed;
>  
>  /* Set PCI function response */
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 2f9b78fa82a5..9b4d3d78b444 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -119,6 +119,7 @@ int zpci_register_ioat(struct zpci_dev *zdev, u8
> dmaas,
>  	fib.pba = base;
>  	fib.pal = limit;
>  	fib.iota = iota | ZPCI_IOTA_RTTO_FLAG;
> +	fib.gd = zdev->gd;
>  	cc = zpci_mod_fc(req, &fib, &status);
>  	if (cc)
>  		zpci_dbg(3, "reg ioat fid:%x, cc:%d, status:%d\n",
> zdev->fid, cc, status);
> @@ -132,6 +133,8 @@ int zpci_unregister_ioat(struct zpci_dev *zdev,
> u8 dmaas)
>  	struct zpci_fib fib = {0};
>  	u8 cc, status;
>  
> +	fib.gd = zdev->gd;
> +
>  	cc = zpci_mod_fc(req, &fib, &status);
>  	if (cc)
>  		zpci_dbg(3, "unreg ioat fid:%x, cc:%d, status:%d\n",
> zdev->fid, cc, status);
> @@ -159,6 +162,7 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
>  	atomic64_set(&zdev->unmapped_pages, 0);
>  
>  	fib.fmb_addr = virt_to_phys(zdev->fmb);
> +	fib.gd = zdev->gd;
>  	cc = zpci_mod_fc(req, &fib, &status);
>  	if (cc) {
>  		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
> @@ -177,6 +181,8 @@ int zpci_fmb_disable_device(struct zpci_dev
> *zdev)
>  	if (!zdev->fmb)
>  		return -EINVAL;
>  
> +	fib.gd = zdev->gd;
> +
>  	/* Function measurement is disabled if fmb address is zero */
>  	cc = zpci_mod_fc(req, &fib, &status);
>  	if (cc == 3) /* Function already gone. */
> @@ -807,6 +813,9 @@ struct zpci_dev *zpci_create_device(u32 fid, u32
> fh, enum zpci_state state)
>  	zdev->fid = fid;
>  	zdev->fh = fh;
>  
> +	/* For now, assume it is not a passthrough device */
> +	zdev->gd = 0;
> +
>  	/* Query function properties and update zdev */
>  	rc = clp_query_pci_fn(zdev);
>  	if (rc)
> diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
> index be077b39da33..e9ed0e4a5cf0 100644
> --- a/arch/s390/pci/pci_clp.c
> +++ b/arch/s390/pci/pci_clp.c
> @@ -240,6 +240,7 @@ static int clp_set_pci_fn(struct zpci_dev *zdev,
> u32 *fh, u8 nr_dma_as, u8 comma
>  		rrb->request.fh = zdev->fh;
>  		rrb->request.oc = command;
>  		rrb->request.ndas = nr_dma_as;
> +		rrb->request.gd = zdev->gd;
>  
>  		rc = clp_req(rrb, CLP_LPS_PCI);
>  		if (rrb->response.hdr.rsp == CLP_RC_SETPCIFN_BUSY) {
> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> index 6b29e39496d1..9e8b4507234d 100644
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
> @@ -43,6 +43,7 @@ static int zpci_set_airq(struct zpci_dev *zdev)
>  	fib.fmt0.aibvo = 0;	/* each zdev has its own interrupt
> vector */
>  	fib.fmt0.aisb = (unsigned long) zpci_sbv->vector + (zdev-
> >aisb/64)*8;
>  	fib.fmt0.aisbo = zdev->aisb & 63;
> +	fib.gd = zdev->gd;
>  
>  	return zpci_mod_fc(req, &fib, &status) ? -EIO : 0;
>  }
> @@ -54,6 +55,8 @@ static int zpci_clear_airq(struct zpci_dev *zdev)
>  	struct zpci_fib fib = {0};
>  	u8 cc, status;
>  
> +	fib.gd = zdev->gd;
> +
>  	cc = zpci_mod_fc(req, &fib, &status);
>  	if (cc == 3 || (cc == 1 && status == 24))
>  		/* Function already gone or IRQs already deregistered.
> */
> @@ -72,6 +75,7 @@ static int zpci_set_directed_irq(struct zpci_dev
> *zdev)
>  	fib.fmt = 1;
>  	fib.fmt1.noi = zdev->msi_nr_irqs;
>  	fib.fmt1.dibvo = zdev->msi_first_bit;
> +	fib.gd = zdev->gd;
>  
>  	return zpci_mod_fc(req, &fib, &status) ? -EIO : 0;
>  }
> @@ -84,6 +88,7 @@ static int zpci_clear_directed_irq(struct zpci_dev
> *zdev)
>  	u8 cc, status;
>  
>  	fib.fmt = 1;
> +	fib.gd = zdev->gd;
>  	cc = zpci_mod_fc(req, &fib, &status);
>  	if (cc == 3 || (cc == 1 && status == 24))
>  		/* Function already gone or IRQs already deregistered.
> */

