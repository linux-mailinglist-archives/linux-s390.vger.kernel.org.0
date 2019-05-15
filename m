Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 197021F81D
	for <lists+linux-s390@lfdr.de>; Wed, 15 May 2019 18:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfEOQEX (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 15 May 2019 12:04:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41294 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726168AbfEOQEX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 May 2019 12:04:23 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4FFw7DO095335;
        Wed, 15 May 2019 12:04:19 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sgmf8np57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 May 2019 12:04:18 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x4F9wuJ1019903;
        Wed, 15 May 2019 10:08:41 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01dal.us.ibm.com with ESMTP id 2sdp14xh1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 May 2019 10:08:41 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4FG4FpF39321712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 16:04:15 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EE7DC605B;
        Wed, 15 May 2019 16:04:15 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 029F7C605D;
        Wed, 15 May 2019 16:04:14 +0000 (GMT)
Received: from [9.56.58.102] (unknown [9.56.58.102])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 15 May 2019 16:04:14 +0000 (GMT)
Subject: Re: [PATCH v2 3/7] s390/cio: Split pfn_array_alloc_pin into pieces
To:     Eric Farman <farman@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
References: <20190514234248.36203-1-farman@linux.ibm.com>
 <20190514234248.36203-4-farman@linux.ibm.com>
From:   Farhan Ali <alifm@linux.ibm.com>
Message-ID: <ab8e6a2b-e8c3-d74a-9af1-5139cdce7e7a@linux.ibm.com>
Date:   Wed, 15 May 2019 12:04:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20190514234248.36203-4-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-15_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=956 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905150097
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 05/14/2019 07:42 PM, Eric Farman wrote:
> The pfn_array_alloc_pin routine is doing too much.  Today, it does the
> alloc of the pfn_array struct and its member arrays, builds the iova
> address lists out of a contiguous piece of guest memory, and asks vfio
> to pin the resulting pages.
> 
> Let's effectively revert a significant portion of commit 5c1cfb1c3948
> ("vfio: ccw: refactor and improve pfn_array_alloc_pin()") such that we
> break pfn_array_alloc_pin() into its component pieces, and have one
> routine that allocates/populates the pfn_array structs, and another
> that actually pins the memory.  In the future, we will be able to
> handle scenarios where pinning memory isn't actually appropriate.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   drivers/s390/cio/vfio_ccw_cp.c | 64 ++++++++++++++++++++++++----------
>   1 file changed, 46 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 41f48b8790bc..60aa784717c5 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -50,28 +50,25 @@ struct ccwchain {
>   };
>   
>   /*
> - * pfn_array_alloc_pin() - alloc memory for PFNs, then pin user pages in memory
> + * pfn_array_alloc() - alloc memory for PFNs
>    * @pa: pfn_array on which to perform the operation
> - * @mdev: the mediated device to perform pin/unpin operations
>    * @iova: target guest physical address
>    * @len: number of bytes that should be pinned from @iova
>    *
> - * Attempt to allocate memory for PFNs, and pin user pages in memory.
> + * Attempt to allocate memory for PFNs.
>    *
>    * Usage of pfn_array:
>    * We expect (pa_nr == 0) and (pa_iova_pfn == NULL), any field in
>    * this structure will be filled in by this function.
>    *
>    * Returns:
> - *   Number of pages pinned on success.
> - *   If @pa->pa_nr is not 0, or @pa->pa_iova_pfn is not NULL initially,
> - *   returns -EINVAL.
> - *   If no pages were pinned, returns -errno.
> + *         0 if PFNs are allocated
> + *   -EINVAL if pa->pa_nr is not initially zero, or pa->pa_iova_pfn is not NULL
> + *   -ENOMEM if alloc failed
>    */
> -static int pfn_array_alloc_pin(struct pfn_array *pa, struct device *mdev,
> -			       u64 iova, unsigned int len)
> +static int pfn_array_alloc(struct pfn_array *pa, u64 iova, unsigned int len)
>   {
> -	int i, ret = 0;
> +	int i;
>   
>   	if (!len)
>   		return 0;
> @@ -97,6 +94,22 @@ static int pfn_array_alloc_pin(struct pfn_array *pa, struct device *mdev,
>   	for (i = 1; i < pa->pa_nr; i++)
>   		pa->pa_iova_pfn[i] = pa->pa_iova_pfn[i - 1] + 1;
>   
> +	return 0;
> +}
> +
> +/*
> + * pfn_array_pin() - Pin user pages in memory
> + * @pa: pfn_array on which to perform the operation
> + * @mdev: the mediated device to perform pin operations
> + *
> + * Returns number of pages pinned upon success.
> + * If the pin request partially succeeds, or fails completely,
> + * all pages are left unpinned and a negative error value is returned.
> + */
> +static int pfn_array_pin(struct pfn_array *pa, struct device *mdev)
> +{
> +	int ret = 0;
> +
>   	ret = vfio_pin_pages(mdev, pa->pa_iova_pfn, pa->pa_nr,
>   			     IOMMU_READ | IOMMU_WRITE, pa->pa_pfn);
>   
> @@ -112,8 +125,6 @@ static int pfn_array_alloc_pin(struct pfn_array *pa, struct device *mdev,
>   
>   err_out:
>   	pa->pa_nr = 0;
> -	kfree(pa->pa_iova_pfn);
> -	pa->pa_iova_pfn = NULL;
>   
>   	return ret;
>   }
> @@ -121,7 +132,9 @@ static int pfn_array_alloc_pin(struct pfn_array *pa, struct device *mdev,
>   /* Unpin the pages before releasing the memory. */
>   static void pfn_array_unpin_free(struct pfn_array *pa, struct device *mdev)
>   {
> -	vfio_unpin_pages(mdev, pa->pa_iova_pfn, pa->pa_nr);
> +	/* Only unpin if any pages were pinned to begin with */
> +	if (pa->pa_nr)
> +		vfio_unpin_pages(mdev, pa->pa_iova_pfn, pa->pa_nr);
>   	pa->pa_nr = 0;
>   	kfree(pa->pa_iova_pfn);
>   }
> @@ -209,10 +222,16 @@ static long copy_from_iova(struct device *mdev,
>   	int i, ret;
>   	unsigned long l, m;
>   
> -	ret = pfn_array_alloc_pin(&pa, mdev, iova, n);
> -	if (ret <= 0)
> +	ret = pfn_array_alloc(&pa, iova, n);
> +	if (ret < 0)
>   		return ret;
>   
> +	ret = pfn_array_pin(&pa, mdev);
> +	if (ret < 0) {
> +		pfn_array_unpin_free(&pa, mdev);
> +		return ret;
> +	}
> +
>   	l = n;
>   	for (i = 0; i < pa.pa_nr; i++) {
>   		from = pa.pa_pfn[i] << PAGE_SHIFT;
> @@ -559,7 +578,11 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
>   	if (ret)
>   		goto out_init;
>   
> -	ret = pfn_array_alloc_pin(pat->pat_pa, cp->mdev, ccw->cda, ccw->count);
> +	ret = pfn_array_alloc(pat->pat_pa, ccw->cda, ccw->count);
> +	if (ret < 0)
> +		goto out_unpin;
> +
> +	ret = pfn_array_pin(pat->pat_pa, cp->mdev);
>   	if (ret < 0)
>   		goto out_unpin;
>   
> @@ -589,6 +612,7 @@ static int ccwchain_fetch_idal(struct ccwchain *chain,
>   {
>   	struct ccw1 *ccw;
>   	struct pfn_array_table *pat;
> +	struct pfn_array *pa;
>   	unsigned long *idaws;
>   	u64 idaw_iova;
>   	unsigned int idaw_nr, idaw_len;
> @@ -627,9 +651,13 @@ static int ccwchain_fetch_idal(struct ccwchain *chain,
>   
>   	for (i = 0; i < idaw_nr; i++) {
>   		idaw_iova = *(idaws + i);
> +		pa = pat->pat_pa + i;
> +
> +		ret = pfn_array_alloc(pa, idaw_iova, 1);
> +		if (ret < 0)
> +			goto out_free_idaws;
>   
> -		ret = pfn_array_alloc_pin(pat->pat_pa + i, cp->mdev,
> -					  idaw_iova, 1);
> +		ret = pfn_array_pin(pa, cp->mdev);
>   		if (ret < 0)
>   			goto out_free_idaws;
>   	}
> 
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>


