Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7E8550FCE
	for <lists+linux-s390@lfdr.de>; Mon, 20 Jun 2022 07:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiFTFwF (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 20 Jun 2022 01:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiFTFwE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 20 Jun 2022 01:52:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E316D10C;
        Sun, 19 Jun 2022 22:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VPvTLYT4uzXPfly43nDQkm0acKhpjiwhyQSa4N3bkPQ=; b=s32C9QgmMV+/otPhxM8zXJJw+v
        Em8xVLshpM2FqxP+P5EHTZDNiUYGS6Jex39ihiv9qZvjzQ5xNJO5z6nbHiqvP1hPZpc/LeUBhYshv
        P4Q3TkuK406IQAVZ8s6qfODMXDtzkna4LJq/Scexutww/2+kySLFHZJz3vjrIv41Mr+0SAYAsYJiq
        wcWkrjQM9GjHnYgAQ22xDvw6IWyVa/MIEDXEm8x89NAIQzhJCQ0xwbOamqarOnfk9rH0Ob8QaCZQ6
        dOp+FXjqG8saetQMpK5RSll0DDODyXG84oR9ClL4GHF7TGTgj3pmkihVuvOD5CHgGe9CqYMgP+TOM
        ymh1DruA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3AKB-00GLAc-2w; Mon, 20 Jun 2022 05:51:47 +0000
Date:   Sun, 19 Jun 2022 22:51:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Nicolin Chen <nicolinc@nvidia.com>, kwankhede@nvidia.com,
        corbet@lwn.net, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com,
        mjrosato@linux.ibm.com, pasic@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com,
        akrowiak@linux.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, cohuck@redhat.com,
        kevin.tian@intel.com, jchrist@linux.ibm.com, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [RFT][PATCH v1 6/6] vfio: Replace phys_pfn with phys_page for
 vfio_pin_pages()
Message-ID: <YrAK87zjdOqUF6gB@infradead.org>
References: <20220616235212.15185-1-nicolinc@nvidia.com>
 <20220616235212.15185-7-nicolinc@nvidia.com>
 <YqxBLbu8yPJiwK6Z@infradead.org>
 <20220620030046.GB5219@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620030046.GB5219@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jun 20, 2022 at 12:00:46AM -0300, Jason Gunthorpe wrote:
> On Fri, Jun 17, 2022 at 01:54:05AM -0700, Christoph Hellwig wrote:
> > There is a bunch of code an comments in the iommu type1 code that
> > suggest we can pin memory that is not page backed.  
> 
> AFAIK you can.. The whole follow_pte() mechanism allows raw PFNs to be
> loaded into the type1 maps and the pin API will happily return
> them. This happens in almost every qemu scenario because PCI MMIO BAR
> memory ends up routed down this path.

Indeed, my read wasn't deep enough.  Which means that we can't change
the ->pin_pages interface to return a struct pages array, as we don't
have one for those.
