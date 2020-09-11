Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14349265A80
	for <lists+linux-s390@lfdr.de>; Fri, 11 Sep 2020 09:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgIKH1i (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 11 Sep 2020 03:27:38 -0400
Received: from verein.lst.de ([213.95.11.211]:35852 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgIKH1g (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 11 Sep 2020 03:27:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 778A768B02; Fri, 11 Sep 2020 09:27:34 +0200 (CEST)
Date:   Fri, 11 Sep 2020 09:27:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org
Subject: s390 PCI dma ops
Message-ID: <20200911072734.GA23043@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi S/390 PCI and IOMMU maintainers,

We've recently tried to convert all implementations of the IOMMU API to
use drivers/iommu/dma-iommu.c instead of their local IOMMU ops.  I've
looked at S/390 and while some comments mention things about the iommu
API the implementation looks quite separate.  Do arch/s390/pci/pci_dma.c
and drivers/iommu/s390-iommu.c driver the same hardware?  If so would a
switch to drivers/iommu/dma-iommu.c be feasibel?
