Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7431A52E6B2
	for <lists+linux-s390@lfdr.de>; Fri, 20 May 2022 09:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244453AbiETH55 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 20 May 2022 03:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346738AbiETH5z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 20 May 2022 03:57:55 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB30814B676
        for <linux-s390@vger.kernel.org>; Fri, 20 May 2022 00:57:49 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 66298820; Fri, 20 May 2022 09:57:45 +0200 (CEST)
Date:   Fri, 20 May 2022 09:57:44 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     jgg@nvidia.com, will@kernel.org, alex.williamson@redhat.com,
        cohuck@redhat.com, borntraeger@linux.ibm.com,
        schnelle@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        farman@linux.ibm.com, iommu@lists.linux-foundation.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/s390: tolerate repeat attach_dev calls
Message-ID: <YodJ+OwxsP5PPO3V@8bytes.org>
References: <20220519182929.581898-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519182929.581898-1-mjrosato@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, May 19, 2022 at 02:29:29PM -0400, Matthew Rosato wrote:
> Since commit 0286300e6045 ("iommu: iommu_group_claim_dma_owner() must
> always assign a domain") s390-iommu will get called to allocate multiple
> unmanaged iommu domains for a vfio-pci device -- however the current
> s390-iommu logic tolerates only one.  Recognize that multiple domains can
> be allocated and handle switching between DMA or different iommu domain
> tables during attach_dev.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  drivers/iommu/s390-iommu.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

Applied to the vfio-notifier-fix topic branch, thanks.

